part of 'complaints_cubit.dart';

enum ComplaintStatus { initial, submitting, success, error }

enum ComplaintBoxStatus { collapsed, expanded }

class ComplaintsState extends Equatable {

  final String title;
  final String description;

  final ComplaintStatus status;
  final String errorMessage;

  final ComplaintBoxStatus complaintBoxStatus;
  
  const ComplaintsState({
    required this.title,
    required this.description,
    required this.status,
    required this.errorMessage,
    required this.complaintBoxStatus});

  factory ComplaintsState.initial() {
    return const ComplaintsState(
        title: '',
        description: '',
        status: ComplaintStatus.initial,
        errorMessage: '',
        complaintBoxStatus: ComplaintBoxStatus.collapsed
    );
  }

  ComplaintsState copyWith({
    String? title,
    String? description,
    ComplaintStatus? status,
    String? errorMessage,
    ComplaintBoxStatus? complaintBoxStatus,
  }) {
    return ComplaintsState(
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        complaintBoxStatus: complaintBoxStatus ?? this.complaintBoxStatus
    );
  }

  @override
  List<Object> get props => [ title, description, status, errorMessage, complaintBoxStatus ];
}
