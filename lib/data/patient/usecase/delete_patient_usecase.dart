import 'package:dartz/dartz.dart';
import '../repository/patient_repository.dart';
import '../../../../core/error/failures.dart';
class DeletePatientUsecase {
  final PatientRepository repository;
  DeletePatientUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.delete(id);
  }
}
