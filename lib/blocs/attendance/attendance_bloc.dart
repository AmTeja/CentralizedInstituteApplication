import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  final AttendanceRepository _attendanceRepository;
  StreamSubscription<List<Session>>? _attendanceSubscription;

  AttendanceBloc({
    required AttendanceRepository attendanceRepository,
  }) : _attendanceRepository = attendanceRepository,
        super(AttendanceLoading()) {
    on<LoadAttendance>(_loadAttendance);
    on<UpdateAttendance>(_updateAttendance);
  }

  void _loadAttendance(
      LoadAttendance event,
      Emitter<AttendanceState> emit
      ) {
    _attendanceSubscription?.cancel();
    _attendanceSubscription = _attendanceRepository.attendance
        .listen((List<Session> sessions) => add(UpdateAttendance(sessions)));
  }

  void _updateAttendance(
      UpdateAttendance event,
      Emitter<AttendanceState> emit
      ) => emit(AttendanceLoaded(sessions: event.sessions));

  @override
  Future<void> close() {
    _attendanceSubscription?.cancel();
    return super.close();
  }
}
