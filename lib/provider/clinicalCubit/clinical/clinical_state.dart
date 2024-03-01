part of 'clinical_cubit.dart';

abstract class ClinicalState extends Equatable {
  const ClinicalState();

  @override
  List<Object> get props => [];
}

class ClinicalInitial extends ClinicalState {}

class ClinicalIsLoadingState extends ClinicalState {}

class ClinicalLoadedState extends ClinicalState {
  final ClinicalModel model;
  
  const ClinicalLoadedState({required this.model});
}

class ClinicalErrorState extends ClinicalState {
  final String message;

  const ClinicalErrorState({required this.message});
}
