import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:patient/core/api/api_consumer.dart';
import 'package:patient/core/api/app_interceptors.dart';
import 'package:patient/core/api/dio_consumer.dart';
import 'package:patient/core/api/netwok_info.dart';
import 'package:patient/data/clinical/datasource/clinical_remote_datasource.dart';
import 'package:patient/data/clinical/repository/clinical_repository.dart';
import 'package:patient/data/clinical/usecase/add_clinical_usecase.dart';
import 'package:patient/data/clinical/usecase/delete_clinical_usecase.dart';
import 'package:patient/data/clinical/usecase/get_clinical_usecase.dart';
import 'package:patient/data/clinical/usecase/get_list_clinical_usecase.dart';
import 'package:patient/data/clinical/usecase/update_clinical_usecase.dart';
import 'package:patient/data/patient/datasource/patient_remote_datasource.dart';
import 'package:patient/data/patient/repository/patient_repository.dart';
import 'package:patient/data/patient/usecase/add_patient_usecase.dart';
import 'package:patient/data/patient/usecase/delete_patient_usecase.dart';
import 'package:patient/data/patient/usecase/get_patient_usecase.dart';
import 'package:patient/data/patient/usecase/update_patient_usecase.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/provider/clinicalCubit/clinical_edit/clinical_edit_cubit.dart';
import 'package:patient/provider/patinetcubit/patient/patient_cubit.dart';
import 'package:patient/provider/patinetcubit/patient_edit/patient_edit_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Patient::START
  sl.registerFactory(() => PatientCubit(get: sl()));
  sl.registerFactory(
      () => PatientEditCubit(add: sl(), update: sl(), delete: sl()));

  sl.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

  sl.registerLazySingleton(() => GetPatientUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddPatientUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePatientUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePatientUsecase(repository: sl()));

  sl.registerLazySingleton<PatientRemoteDataSource>(
      () => PatientRemoteDataSourceImpl(apiConsumer: sl()));

// Patient::END

// Clinical::START
  sl.registerFactory(() => ClinicalCubit(get: sl(),getList: sl()));
  sl.registerFactory(
      () => ClinicalEditCubit(add: sl(), update: sl(), delete: sl()));

  sl.registerLazySingleton<ClinicalRepository>(
      () => ClinicalRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

  sl.registerLazySingleton(() => GetClinicalUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetListClinicalUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddClinicalUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteClinicalUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateClinicalUsecase(repository: sl()));

  sl.registerLazySingleton<ClinicalRemoteDataSource>(
      () => ClinicalRemoteDataSourceImpl(apiConsumer: sl()));

// Clinical::END
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
