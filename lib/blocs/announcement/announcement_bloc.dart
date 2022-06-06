import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {

  final AnnouncementsRepository _announcementsRepository;
  StreamSubscription? _announcementSubscription;

  AnnouncementBloc({required AnnouncementsRepository announcementsRepository})
      : _announcementsRepository = announcementsRepository,
        super(AnnouncementLoading()) {
    on<LoadAnnouncements>(_onLoadAnnouncements);
    on<UpdateAnnouncements>(_onUpdateAnnouncements);
  }

  void _onLoadAnnouncements(
      LoadAnnouncements event,
      Emitter<AnnouncementState> emit
      ) {
    _announcementSubscription?.cancel();
    _announcementSubscription = _announcementsRepository.announcement
        .listen((List<Announcement> announcements) => add(
        UpdateAnnouncements(announcements)
    ));
  }

  void _onUpdateAnnouncements(
      UpdateAnnouncements event,
      Emitter<AnnouncementState> emit
      ) => emit(AnnouncementLoaded(announcements: event.announcements));

}
