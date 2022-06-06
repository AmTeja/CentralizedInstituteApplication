import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  final ComplaintsRepository _complaintsRepository;
  StreamSubscription<List<Complaint>>? _complaintsSubscription;

  ComplaintsBloc({
    required ComplaintsRepository complaintsRepository
}) : _complaintsRepository = complaintsRepository,
        super(ComplaintsLoading()) {
    on<LoadComplaints>(_onLoadComplaints);
    on<UpdateComplaints>(_onUpdateComplaints);
  }

  void _onLoadComplaints(
    LoadComplaints event,
    Emitter<ComplaintsState> emit
      ) {
    _complaintsSubscription?.cancel();
    _complaintsSubscription = _complaintsRepository.complaints
        .listen((List<Complaint> complaints) => add(UpdateComplaints(complaints)));
  }

  void _onUpdateComplaints(
      UpdateComplaints event,
      Emitter<ComplaintsState> emit
      ) => emit(ComplaintsLoaded(complaints: event.complaints));

  @override
  Future<void> close() {
   _complaintsSubscription?.cancel();
   return super.close();
  }

}
