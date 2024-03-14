import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../datasource/clinical_remote_datasource.dart';
import '../../../../core/api/netwok_info.dart';
import '../model/clinical_model.dart';
import '../model/upload_clinical_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class ClinicalRepository {
  Future<Either<Failure, ClinicalModel>> get(ClinicalDataModel model);
  Future<Either<Failure, PatientModel>> getList();
  Future<Either<Failure, ResponseUploadClinicalModel>> add(
      ClinicalDataModel model);
  Future<Either<Failure, Unit>> update(ClinicalDataModel model);
  Future<Either<Failure, Unit>> delete(int id);
}

class ClinicalRepositoryImpl implements ClinicalRepository {
  final NetworkInfo networkInfo;
  final ClinicalRemoteDataSource remoteDatasource;
  ClinicalRepositoryImpl(
      {required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, ClinicalModel>> get(ClinicalDataModel mdoel) async {
    if (await networkInfo.isConnected) {
      try {
        final reposnse = await remoteDatasource.get(mdoel);
        return Right(reposnse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {}
    throw const ServerException();
  }

  @override
  Future<Either<Failure, PatientModel>> getList() async {
    if (await networkInfo.isConnected) {
      try {
        final reposnse = await remoteDatasource.getList();
        return Right(reposnse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {}
    throw const ServerException();
  }

  @override
  Future<Either<Failure, ResponseUploadClinicalModel>> add(
      ClinicalDataModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final reposnse = await remoteDatasource.add(model);
        return Right(reposnse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {}
    throw const ServerException();
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await _getMessage(() {
      return remoteDatasource.delete(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> update(ClinicalDataModel model) async {
    if (await networkInfo.isConnected) {
      try {
        final reposnse = await remoteDatasource.update(model);
        return Right(reposnse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {}
    throw const ServerException();
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddRate deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

typedef DeleteOrUpdateOrAddRate = Future<Unit> Function();
