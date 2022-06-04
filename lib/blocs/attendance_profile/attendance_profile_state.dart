part of 'attendance_profile_bloc.dart';

abstract class AttendanceProfileState extends Equatable {
  const AttendanceProfileState();

  @override
  List<Object> get props => [];
}

class AttendanceProfileLoading extends AttendanceProfileState {}

class AttendanceProfileLoaded extends AttendanceProfileState {

  final AttendanceProfile attendanceProfile;

  const AttendanceProfileLoaded({this.attendanceProfile = AttendanceProfile.empty});

  @override
  List<Object> get props => [attendanceProfile];
}
