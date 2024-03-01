import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';

import '../../../../data/clinical/usecase/add_clinical_usecase.dart';
import '../../../../data/clinical/usecase/delete_clinical_usecase.dart';
import '../../../../data/clinical/usecase/update_clinical_usecase.dart';

part 'clinical_edit_state.dart';

class ClinicalEditCubit extends Cubit<ClinicalEditState> {
  final AddClinicalUsecase add;
  final UpdateClinicalUsecase update;
  final DeleteClinicalUsecase delete;
  ClinicalEditCubit(
      {required this.add, required this.update, required this.delete})
      : super(ClinicalEditInitial());

  void addClinical(ClinicalDataModel model) async {
    emit(ClinicalEditIsLoadingState());
    final response = await add(model);
    emit(response.fold(
        (l) => ClinicalEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalEditSuccessState()));
  }

  void updateClinical(ClinicalDataModel model) async {
    emit(ClinicalEditIsLoadingState());
    final response = await update(model);
    emit(response.fold(
        (l) => ClinicalEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalEditSuccessState()));
  }

  void deleteClinical(int id) async {
    emit(ClinicalEditIsLoadingState());
    final response = await delete(id);
    emit(response.fold(
        (l) => ClinicalEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalEditSuccessState()));
  }
}
