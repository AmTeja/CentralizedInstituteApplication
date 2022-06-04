import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(ComplaintsInitial());
}
