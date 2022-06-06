part of 'complaints_bloc.dart';

abstract class ComplaintsEvent extends Equatable {
  const ComplaintsEvent();

  @override
  List<Object> get props => [];
}

class LoadComplaints extends ComplaintsEvent {}

class UpdateComplaints extends ComplaintsEvent {

  final List<Complaint> complaints;

  const UpdateComplaints(this.complaints);

  @override
  List<Object> get props => [complaints];
}