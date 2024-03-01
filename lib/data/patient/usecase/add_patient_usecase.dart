import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../repository/patient_repository.dart';
import '../model/upload_patient_model.dart';
import '../../../../core/error/failures.dart';
class AddPatientUsecase {
  final PatientRepository repository;
  AddPatientUsecase({required this.repository});
  Future<Either<Failure, ResponseUploadPatientModel>> call(PatientDataModel model) async {
    return await repository.add(model);
  }
}
