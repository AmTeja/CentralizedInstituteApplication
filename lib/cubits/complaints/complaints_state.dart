part of 'complaints_cubit.dart';

enum ComplaintStatus { initial, submitting, success, error }

abstract class ComplaintsState extends Equatable {
  const ComplaintsState();
}

class ComplaintsInitial extends ComplaintsState {
  @override
  List<Object> get props => [];
}
