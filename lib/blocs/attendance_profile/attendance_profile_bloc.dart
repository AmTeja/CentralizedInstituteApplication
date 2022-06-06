import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'attendance_profile_event.dart';
part 'attendance_profile_state.dart';

class AttendanceProfileBloc extends Bloc<AttendanceProfileEvent, AttendanceProfileState> {
  final AttendanceRepository _attendanceRepository;
  StreamSubscription<AttendanceProfile>? _attendanceProfileSubscription;

  AttendanceProfileBloc({
    required AttendanceRepository attendanceRepository
  }) : _attendanceRepository = attendanceRepository,
        super(AttendanceProfileLoading()) {
    on<LoadAttendanceProfile>(_onLoadAttendanceProfile);
    on<UpdateAttendanceProfile>(_onUpdateAttendanceProfile);
  }

  void _onLoadAttendanceProfile(
      LoadAttendanceProfile event,
      Emitter<AttendanceProfileState> emit
      ) {
    _attendanceProfileSubscription?.cancel();
    _attendanceProfileSubscription = _attendanceRepository.attendanceProfile
        .listen((AttendanceProfile attendanceProfile) => add(UpdateAttendanceProfile(attendanceProfile)));
  }

  void _onUpdateAttendanceProfile(
      UpdateAttendanceProfile event,
      Emitter<AttendanceProfileState> emit
      ) => emit(AttendanceProfileLoaded(attendanceProfile: event.attendanceProfile));

  @override
  Future<void> close() {
    _attendanceProfileSubscription?.cancel();
    return super.close();
  }

}
