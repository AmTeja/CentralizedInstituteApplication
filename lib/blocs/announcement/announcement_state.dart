part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object> get props => [];
}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {

  final List<Announcement> announcements;

  const AnnouncementLoaded({this.announcements = const <Announcement>[]});

  @override
  List<Object> get props => [announcements];
}
