part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final StudentProfile studentProfile;

  const UpdateProfile(this.studentProfile);

  @override
  List<Object> get props => [studentProfile];
}
