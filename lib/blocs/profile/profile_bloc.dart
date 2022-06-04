import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final ProfileRepository _profileRepository;
  StreamSubscription<StudentProfile>? _profileSubscription;

  ProfileBloc({
    required ProfileRepository profileRepository
  })
      : _profileRepository = profileRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_mapLoadProfileToState);
    on<UpdateProfile>(_mapUpdateProfileToState);
  }

  void _mapLoadProfileToState(
      LoadProfile event,
      Emitter<ProfileState> emit
      ) {
    _profileSubscription?.cancel();
    _profileSubscription = _profileRepository.profile.listen((studentProfile) => add(UpdateProfile(studentProfile)));
  }

  Future<void> _mapUpdateProfileToState(
      UpdateProfile event,
      Emitter<ProfileState> emit
      ) async {
    emit(ProfileLoaded(studentProfile: event.studentProfile));
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }
}
