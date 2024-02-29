import 'package:dartz/dartz.dart';
import '../repository/patient_repository.dart';
import '../../../../core/error/failures.dart';
import '../model/patient_model.dart';


class GetPatientUsecase {
  final PatientRepository repository;
  GetPatientUsecase({required this.repository});
  Future<Either<Failure, PatientModel>> call() async {
    return await repository.get();
  }
}
