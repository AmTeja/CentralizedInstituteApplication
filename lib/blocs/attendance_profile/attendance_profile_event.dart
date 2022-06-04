part of 'attendance_profile_bloc.dart';

abstract class AttendanceProfileEvent extends Equatable {
  const AttendanceProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceProfile extends AttendanceProfileEvent {}

class UpdateAttendanceProfile extends AttendanceProfileEvent {

  final AttendanceProfile attendanceProfile;

  const UpdateAttendanceProfile(this.attendanceProfile);

  @override
  List<Object> get props => [attendanceProfile];
}
