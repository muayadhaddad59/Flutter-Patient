import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/end_points.dart';
import '../model/patient_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/status_code.dart';
import '../model/upload_patient_model.dart';

abstract class PatientRemoteDataSource {
  Future<PatientModel> get();
  Future<ResponseUploadPatientModel> add(UploadPatientModel model);
  Future<Unit> update(UploadPatientModel model);
  Future<Unit> delete(int id);
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final ApiConsumer apiConsumer;

  PatientRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<PatientModel> get() async {

    final Response response = await apiConsumer.get(EndPoints.patient);
    if (response.statusCode == StatusCode.ok) {
      try {
        final PatientModel decodedJson =
            PatientModel.fromJson(json.decode(response.data));
        return decodedJson;
      } catch (e) {
        throw const FetchDataException();
      }
    } else {
      throw const ServerException();
    }

  }

  @override
  Future<ResponseUploadPatientModel> add(UploadPatientModel model) async{
     final response = await apiConsumer
        .post(EndPoints.patient);
    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        final ResponseUploadPatientModel decodedJson =
            ResponseUploadPatientModel.fromJson(json.decode(response.data));
        return decodedJson;
      } catch (e) {
        throw const FetchDataException();
      }
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Unit> delete(int id) async{
   final response = await apiConsumer
        .delete(EndPoints.patient);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Unit> update(UploadPatientModel model) async{
  final response = await apiConsumer
        .put(EndPoints.patient);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw const ServerException();
    }
  }
}