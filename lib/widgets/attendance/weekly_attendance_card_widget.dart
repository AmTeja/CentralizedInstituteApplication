import 'package:cia/blocs/blocs.dart';
import 'package:cia/config/custom_indicator_painter.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeeklyAttendanceCard extends StatelessWidget {

  const WeeklyAttendanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24.0),
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
          child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              if(state is AttendanceLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state is AttendanceLoaded) {
                return  DefaultTabController(
                  initialIndex: state.days - 1,
                  length: state.days,
                  child: Column(
                    children:  [
                      Expanded(
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: state.categorizedSessions.map((e) {
                              return DayAttendanceTabView(sessions: e);
                            }).toList()
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            indicator: const MD2Indicator(
                              indicatorSize: MD2IndicatorSize.tiny,
                              indicatorHeight: 2.0,
                              indicatorColor: Color(0xFF464B63),
                            ),
                            labelStyle: const TextStyle(fontSize: 15),
                            labelColor:  const Color(0xFF464B63),
                            unselectedLabelColor: const Color(0xFF464B63).withAlpha(115),
                            tabs: state.categorizedSessions.map((e) => Tab(
                              text: DateFormat('E').format(e.key)[0],
                              height: 20,
                            )).toList()
                        ),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                );
              }
              return const Center(child: Text("Something went wrong!"),);
            },
          ),
        ),
      ),
    );
  }
}
