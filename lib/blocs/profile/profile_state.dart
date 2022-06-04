part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {

  final StudentProfile studentProfile;

  const ProfileLoaded({this.studentProfile = StudentProfile.empty});

  @override
  List<Object> get props => [studentProfile];
}
