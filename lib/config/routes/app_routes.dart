import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/core/utils/app_service.dart';
import 'package:patient/provider/patinetcubit/patient/patient_cubit.dart';

import 'package:patient/view/navBar/nav_bar.dart';
import 'package:patient/view/patient/screen/patinet_info_screen.dart';
import 'package:patient/view/patient/screen/list_patient_screen.dart';

class Routes {
  static const String init = "/";
  static const String patientList = "/patientList";
  static const String addPatient = "/addPatientScreen";
  static const String addMedicalInfoScreen = "/addMedicalInfoScreen";
  static const String addInsuranceInfo = "/addInsuranceInfo";
  static const String addClinicalTestScreen = "/addClinicalTestScreen";

  static const String forgetPassword = "/forgetPassword";
  static const String mainScren = "/mainScreen";
  static const String login = "/login";
  static const String adminMainScreen = "/adminMainScreen";
}

class AppRoutes {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.init:
        return MaterialPageRoute(
          builder: (context) {
            return const NavBar();
          },
        );
      case Routes.patientList:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => sl<PatientCubit>()..getPatient(),
              child: const ListPatientScreen(),
            );
          },
        );
      case Routes.addPatient:
        return MaterialPageRoute(
          builder: (context) {
            return const AddPatientScreen();
          },
        );

      default:
    }
    return null;
  }
}
