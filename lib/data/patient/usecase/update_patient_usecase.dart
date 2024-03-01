import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../repository/patient_repository.dart';
import '../../../../core/error/failures.dart';

class UpdatePatientUsecase {
  final PatientRepository repository;
  UpdatePatientUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(PatientDataModel model) async {
    return await repository.update(model);
  }
}
