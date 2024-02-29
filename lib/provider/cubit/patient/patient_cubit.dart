import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../../../../data/patient/usecase/get_patient_usecase.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
    final GetPatientUsecase get;
  PatientCubit({required this.get}) : super(PatientInitial());

    void getPatient() async {
    emit(PatientIsLoadingState());
    final response = await get();
    emit(response.fold(
        (l) => PatientErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) =>PatientLoadedState(model: r)));
  }

}

