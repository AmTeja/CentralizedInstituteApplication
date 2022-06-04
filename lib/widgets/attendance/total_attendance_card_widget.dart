import 'package:cia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalAttendanceCard extends StatelessWidget {

  const TotalAttendanceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Material(
        borderRadius: BorderRadius.circular(13),
        elevation: 4,
        child: BlocBuilder<AttendanceProfileBloc, AttendanceProfileState>(
          builder: (context, state) {
            if(state is AttendanceProfileLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is AttendanceProfileLoaded) {
              double totalPercentage = (state.attendanceProfile.totalAttended/state.attendanceProfile.totalHeld) * 100;
              return Container(
                decoration: BoxDecoration(
                  color: totalPercentage <= 70   ? const Color(0xFFFF006E) : const Color(0xFF50B432),
                  borderRadius: BorderRadius.circular(13),
                ),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 1,
                                right: 1,
                                top: 1,
                                bottom: 1,
                                child: RotatedBox(
                                    quarterTurns: 2,
                                    child: CircularProgressIndicator(value: totalPercentage/100, color: Colors.white, backgroundColor: Colors.white.withOpacity(0.6),)),
                              ),
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("${totalPercentage.toStringAsPrecision(2)}%", style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),))),
                            ],
                          )),
                    ),
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(totalPercentage <= 70 ? "Your attendance is Low" : "Good going", style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),),
                        ))
                  ],
                ),
              );
            }
            return const Center(child: Text("Something went wrong!"),);
          },
        )
      ),
    );
  }
}