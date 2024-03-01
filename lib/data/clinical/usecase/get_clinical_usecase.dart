import 'package:dartz/dartz.dart';
import '../repository/clinical_repository.dart';
import '../../../../core/error/failures.dart';
import '../model/clinical_model.dart';


class GetClinicalUsecase {
  final ClinicalRepository repository;
  GetClinicalUsecase({required this.repository});
  Future<Either<Failure, ClinicalModel>> call(ClinicalDataModel model) async {
    return await repository.get(model);
  }
}
