import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/upload_patient_model.dart';
import '../repository/patient_repository.dart';
import '../../../../core/error/failures.dart';

class UpdatePatientUsecase {
  final PatientRepository repository;
  UpdatePatientUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(UploadPatientModel model) async {
    return await repository.update(model);
  }
}
