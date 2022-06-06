part of 'complaints_bloc.dart';

abstract class ComplaintsState extends Equatable {
  const ComplaintsState();

  @override
  List<Object> get props => [];
}

class ComplaintsLoading extends ComplaintsState {}

class ComplaintsLoaded extends ComplaintsState {

  final List<Complaint> complaints;

  const ComplaintsLoaded({this.complaints = const <Complaint>[]});

  @override
  List<Object> get props => [complaints];
}