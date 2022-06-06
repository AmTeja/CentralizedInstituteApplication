part of 'announcement_bloc.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object> get props => [];
}

class LoadAnnouncements extends AnnouncementEvent {}

class UpdateAnnouncements extends AnnouncementEvent {

  final List<Announcement> announcements;

  const UpdateAnnouncements(this.announcements);

  @override
  List<Object> get props => [announcements];
}

