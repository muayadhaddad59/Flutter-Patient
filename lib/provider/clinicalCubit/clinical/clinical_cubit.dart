import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import '../../../../data/clinical/usecase/get_clinical_usecase.dart';

part 'clinical_state.dart';

class ClinicalCubit extends Cubit<ClinicalState> {
  final GetClinicalUsecase get;
  ClinicalCubit({required this.get}) : super(ClinicalInitial());

  void getClinical(ClinicalDataModel mdoel) async {
    emit(ClinicalIsLoadingState());
    final response = await get(mdoel);
    emit(response.fold(
        (l) => ClinicalErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => ClinicalLoadedState(model: r)));
  }
}
