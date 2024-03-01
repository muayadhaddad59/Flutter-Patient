part of 'patient_cubit.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

class PatientInitial extends PatientState {}

class PatientIsLoadingState extends PatientState {}

class PatientLoadedState extends PatientState {
  final PatientModel model;
  
  const PatientLoadedState({required this.model});
}

class PatientErrorState extends PatientState {
  final String message;

  const PatientErrorState({required this.message});
}
