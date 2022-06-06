import 'package:bloc/bloc.dart';
import 'package:cia/cubits/cubits.dart';
import 'package:cia/models/models.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {

  final ComplaintsRepository _complaintsRepository;

  ComplaintsCubit(this._complaintsRepository) : super(ComplaintsState.initial());

  void titleChanged(String value) {
    emit(state.copyWith(title: value, status: ComplaintStatus.initial));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, status: ComplaintStatus.initial));
  }

  void complaintBoxSizeChanged(bool isExpanded) {
    emit(state.copyWith(
        complaintBoxStatus: isExpanded
        ? ComplaintBoxStatus.collapsed
        : ComplaintBoxStatus.expanded
    ));
  }

  Future<void> addComplaint() async {
    if(state.status == ComplaintStatus.submitting) return;
    if(state.title.isEmpty) {
      emit(state.copyWith(status: ComplaintStatus.error, errorMessage: "Title cannot be empty"));
      return;
    }
    if(state.description.isEmpty) {
      emit(state.copyWith(status: ComplaintStatus.error, errorMessage: "Description cannot be empty"));
      return;
    }
    emit(state.copyWith(status: ComplaintStatus.submitting));
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      Complaint complaint = Complaint(
          resolved: false,
          filedByEmail: firebaseAuth.currentUser!.email!,
          title: state.title,
          description: state.description,
          filedOn: DateTime.now()
      );
      await _complaintsRepository.complaint(complaint);
      emit(state.copyWith(
        title: '',
        description: '',
        errorMessage: '',
        complaintBoxStatus: ComplaintBoxStatus.collapsed,
        status: ComplaintStatus.success,));
    } catch (_) {
      emit(state.copyWith(status: ComplaintStatus.error, errorMessage: _.toString()));
    }
  }
}
