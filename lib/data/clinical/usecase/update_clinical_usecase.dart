import 'package:dartz/dartz.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';

import '../repository/clinical_repository.dart';
import '../../../../core/error/failures.dart';

class UpdateClinicalUsecase {
  final ClinicalRepository repository;
  UpdateClinicalUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(ClinicalDataModel model) async {
    return await repository.update(model);
  }
}
