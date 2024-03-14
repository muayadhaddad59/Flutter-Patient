import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/data/clinical/usecase/get_list_clinical_usecase.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../../../../data/clinical/usecase/get_clinical_usecase.dart';

part 'clinical_state.dart';

class ClinicalCubit extends Cubit<ClinicalState> {
  final GetClinicalUsecase get;
  final GetListClinicalUsecase getList;
  ClinicalCubit({required this.get, required this.getList})
      : super(ClinicalInitial());

  void getClinical(ClinicalDataModel mdoel) async {
    emit(ClinicalIsLoadingState());
    final response = await get(mdoel);
    emit(response.fold(
        (l) => ClinicalErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalLoadedState(model: r)));
  }

  void getListCritical() async {
    emit(ClinicalIsLoadingState());
    final response = await getList();
    emit(response.fold(
        (l) => ClinicalErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalListLoadedState(model: r)));
  }
}
