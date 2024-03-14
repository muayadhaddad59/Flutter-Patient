import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../repository/clinical_repository.dart';
import '../../../../core/error/failures.dart';


class GetListClinicalUsecase {
  final ClinicalRepository repository;
  GetListClinicalUsecase({required this.repository});
  Future<Either<Failure, PatientModel>> call() async {
    return await repository.getList();
  }
}
