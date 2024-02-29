part of 'patient_edit_cubit.dart';

abstract class PatientEditState extends Equatable {
  const PatientEditState();

  @override
  List<Object> get props => [];
}

class PatientEditInitial extends PatientEditState {}

class PatientEditIsLoadingState extends PatientEditState {}

class PatientEditSuccessState extends PatientEditState {}

class PatientEditErrorState extends PatientEditState {
  final String message;

  const PatientEditErrorState({required this.message});
}
