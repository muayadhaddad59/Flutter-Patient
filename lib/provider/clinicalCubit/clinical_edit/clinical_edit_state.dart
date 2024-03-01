part of 'clinical_edit_cubit.dart';

abstract class ClinicalEditState extends Equatable {
  const ClinicalEditState();

  @override
  List<Object> get props => [];
}

class ClinicalEditInitial extends ClinicalEditState {}

class ClinicalEditIsLoadingState extends ClinicalEditState {}

class ClinicalEditSuccessState extends ClinicalEditState {}

class ClinicalEditErrorState extends ClinicalEditState {
  final String message;

  const ClinicalEditErrorState({required this.message});
}
