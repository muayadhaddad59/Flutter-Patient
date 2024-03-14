import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/end_points.dart';
import '../model/clinical_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/status_code.dart';
import '../model/upload_clinical_model.dart';

abstract class ClinicalRemoteDataSource {
  Future<ClinicalModel> get(ClinicalDataModel model);
  Future<PatientModel> getList();
  Future<ResponseUploadClinicalModel> add(ClinicalDataModel model);
  Future<Unit> update(ClinicalDataModel model);
  Future<Unit> delete(int id);
}

class ClinicalRemoteDataSourceImpl implements ClinicalRemoteDataSource {
  final ApiConsumer apiConsumer;

  ClinicalRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<ClinicalModel> get(ClinicalDataModel model) async {
    final Response response = await apiConsumer
        .get("${EndPoints.clinical}/${model.sId}/clinicaldata");
    if (response.statusCode == StatusCode.ok) {
      try {
        final ClinicalModel decodedJson =
            ClinicalModel.fromJson(json.decode(response.data));
        return decodedJson;
      } catch (e) {
        throw const FetchDataException();
      }
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<ResponseUploadClinicalModel> add(ClinicalDataModel model) async {
    final response = await apiConsumer.post(
        "${EndPoints.clinical}/${model.patientId}/clinicaldata",
        body: model.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        final ResponseUploadClinicalModel decodedJson =
            ResponseUploadClinicalModel.fromJson(json.decode(response.data));
        return decodedJson;
      } catch (e) {
        throw const FetchDataException();
      }
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Unit> delete(int id) async {
    final response = await apiConsumer.delete(EndPoints.clinical);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Unit> update(ClinicalDataModel model) async {
    final response = await apiConsumer.post(
        "${EndPoints.clinical}/${model.patientId}/clinicaldata",
        body: model.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        return Future.value(unit);
      } catch (e) {
        throw const FetchDataException();
      }
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<PatientModel> getList() async {
    final Response response =
        await apiConsumer.get("${EndPoints.clinical}/critical");
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
}
