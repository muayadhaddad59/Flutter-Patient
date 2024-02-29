import 'package:dartz/dartz.dart';
import '../datasource/patient_remote_datasource.dart';
import '../../../../core/api/netwok_info.dart';
import '../model/patient_model.dart';
import '../model/upload_patient_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class PatientRepository {
  Future<Either<Failure, PatientModel>> get();
  Future<Either<Failure, ResponseUploadPatientModel>> add(UploadPatientModel model);
  Future<Either<Failure, Unit>> update(UploadPatientModel model);
  Future<Either<Failure, Unit>> delete(int id);
}

class PatientRepositoryImpl implements PatientRepository {
  final NetworkInfo networkInfo;
  final PatientRemoteDataSource remoteDatasource;
  PatientRepositoryImpl(
      {required this.networkInfo, required this.remoteDatasource}); 
  
  
  @override
  Future<Either<Failure, PatientModel>> get() async {
    if (await networkInfo.isConnected) {
      try {
        final reposnse = await remoteDatasource.get();
        return Right(reposnse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {}
    throw const ServerException();
  }


  @override
  Future<Either<Failure, ResponseUploadPatientModel>> add(UploadPatientModel model) async {
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
  Future<Either<Failure, Unit>> update(UploadPatientModel model) async {
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
