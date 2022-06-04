import 'package:cia/blocs/blocs.dart';
import 'package:cia/config/routes.dart';
import 'package:cia/config/theme.dart';
import 'package:cia/models/models.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatelessWidget {

  static Route route() {
    return fadeRoute(const AttendanceScreen());
  }

  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TopBar(isProfileLeading: true,),
          ),
          TotalAttendanceCard(),
          WeeklyAttendanceCard(),
          // SubjectAttendanceContainer()
        ],
      ),
    );
  }
}

class SubjectAttendanceContainer extends StatefulWidget {
  const SubjectAttendanceContainer({Key? key}) : super(key: key);

  @override
  State<SubjectAttendanceContainer> createState() => _SubjectAttendanceContainerState();
}

class _SubjectAttendanceContainerState extends State<SubjectAttendanceContainer> {

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 24.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: BlocBuilder<AttendanceProfileBloc, AttendanceProfileState>(
            builder: (context, state) {
              if(state is AttendanceProfileLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if(state is AttendanceProfileLoaded) {
                List<CourseProfile> courses = state.attendanceProfile.courseProfiles;

                List<DropdownMenuItem<String>> items = courses.map((course) {
                  return DropdownMenuItem<String>(
                      value: course.courseCode,
                      child: Center(
                        child: Text(course.courseName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5!
                              .copyWith(color: const Color(0xFF295BE9)),),
                      ));
                }).toList();

                items.add(DropdownMenuItem<String>(
                    value: "all",
                    child: Center(
                      child: Text("Overall",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5!
                              .copyWith(color: const Color(0xFF295BE9))),
                    )
                ));
                items.sort((a, b) => a.value.toString().toLowerCase().compareTo(b.value.toString().toLowerCase()));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: const Color(0xFF295BE9),
                              style: BorderStyle.solid,),
                        ),
                        child: DropdownButton(
                            enableFeedback: true,
                            icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                            value: selectedValue,
                            alignment: Alignment.center,
                            underline: Container(),
                            items: items,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            }
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return SubjectAttendanceCard(courses: courses, selectedValue: selectedValue!,);
                      }
                    )
                  ],
                );
              }

              return const Center(child: Text("Something went wrong!"),);
            },
          )
        ),
      ),
    );
  }
}

class SubjectAttendanceCard extends StatelessWidget {

  final List<CourseProfile> courses;
  final String selectedValue;

  SubjectAttendanceCard({
    Key? key, required this.courses,
    required this.selectedValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    CourseProfile? courseProfile = selectedValue != "all" ? courses[courses.indexWhere((element) => element.courseCode == selectedValue)] : null;
    return Expanded(child: AttendanceChart(courseProfiles: selectedValue == "all" ? courses : [courseProfile!],));
  }
}

class AttendanceChart extends StatefulWidget {

  final List<CourseProfile>? courseProfiles;

  const AttendanceChart({Key? key, this.courseProfiles}) : super(key: key);

  @override
  State<AttendanceChart> createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {

  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections()),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {

      return List.generate(2, (index) {
        final isTouched = index == touchedIndex;
        final fontSize = isTouched ? 20.0 : 16.0;
        final radius = isTouched ? 110.0 : 100.0;
        final widgetSize = isTouched ? 55.0 : 40.0;
        var course = widget.courseProfiles![0];
        var attendedPercent = (course.totalAttended)/(course.totalHeld);
        switch (index) {
          case 0:
            return PieChartSectionData(
                value: attendedPercent * 100,
                color: colorsForChart[1],
                title: "Attended: ${course.totalAttended}",
                radius: radius,
                titleStyle: TextStyle(fontSize: fontSize)
            );
          case 1:
            return PieChartSectionData(
              value: (100 - (attendedPercent * 100)),
              color: colorsForChart[0],
              title: "Absent: ${course.totalHeld - course.totalAttended}",
              radius: radius,
              titleStyle: TextStyle(fontSize: fontSize)
            );
          default:
            throw "oops";
        }
      });
  }
}



