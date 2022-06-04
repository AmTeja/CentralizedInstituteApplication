part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {

  final List<Session> sessions;
  late int days;
  late List<MapEntry<DateTime, List<Session>>> categorizedSessions;

  AttendanceLoaded({this.sessions = const <Session>[]}) {
    categorizedSessions = groupBy(sessions, (Session session) => DateTime(session.startTime.year,
       session.startTime.month,
       session.startTime.day)).entries.toList();

    for(var category in categorizedSessions) {
      var val = category.value;
      var test = val.groupListsBy((element) => element.courseCode);
      for(var key in test.keys) {
        if(test[key]!.length > 1) {
          Session newSession = test[key]![0].copyWith(numHeld: test[key]!.length, numAttended: (test[key]![0].numAttended! + (test[key]![1].attended ? 1 : 0)));
          val.removeWhere((element) => element.courseCode == key);
          val.add(newSession);
        }
      }
    }

   days = categorizedSessions.length;
  }

  @override
  List<Object> get props => [sessions, days, categorizedSessions];
}