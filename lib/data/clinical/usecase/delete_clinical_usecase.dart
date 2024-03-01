import 'package:dartz/dartz.dart';
import '../repository/clinical_repository.dart';
import '../../../../core/error/failures.dart';
class DeleteClinicalUsecase {
  final ClinicalRepository repository;
  DeleteClinicalUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.delete(id);
  }
}
