part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];

}

class LoadAttendance extends AttendanceEvent {}

class UpdateAttendance extends AttendanceEvent {
  final List<Session> sessions;

  const UpdateAttendance(this.sessions);

  @override
  List<Object> get props => [sessions];
}
