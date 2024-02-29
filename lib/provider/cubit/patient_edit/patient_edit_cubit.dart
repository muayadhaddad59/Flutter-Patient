import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/patient/model/upload_patient_model.dart';
import '../../../../data/patient/usecase/add_patient_usecase.dart';
import '../../../../data/patient/usecase/delete_patient_usecase.dart';
import '../../../../data/patient/usecase/update_patient_usecase.dart';
part 'patient_edit_state.dart';

class PatientEditCubit extends Cubit<PatientEditState> {
  final AddPatientUsecase add;
  final UpdatePatientUsecase update;
  final DeletePatientUsecase delete;
  PatientEditCubit(
      {required this.add, required this.update, required this.delete})
      : super(PatientEditInitial());

  void addPatient(UploadPatientModel model) async {
    emit(PatientEditIsLoadingState());
    final response = await add(model);
    emit(response.fold(
        (l) => PatientEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => PatientEditSuccessState()));
  }

  void updatePatient(UploadPatientModel model) async {
    emit(PatientEditIsLoadingState());
    final response = await update(model);
    emit(response.fold(
        (l) => PatientEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => PatientEditSuccessState()));
  }

  void deletePatient(int id) async {
    emit(PatientEditIsLoadingState());
    final response = await delete(id);
    emit(response.fold(
        (l) => PatientEditErrorState(message: HelperMethod.mapFailureToMsg(l)),
        (r) => PatientEditSuccessState()));
  }
}
