import 'package:dartz/dartz.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import '../repository/clinical_repository.dart';
import '../model/upload_clinical_model.dart';
import '../../../../core/error/failures.dart';
class AddClinicalUsecase {
  final ClinicalRepository repository;
  AddClinicalUsecase({required this.repository});
  Future<Either<Failure, ResponseUploadClinicalModel>> call(ClinicalDataModel model) async {
    return await repository.add(model);
  }
}
