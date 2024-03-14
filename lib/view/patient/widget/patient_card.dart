import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/core/utils/navigator_extension.dart';
import '../../../data/patient/model/patient_model.dart';
import '../screen/patien_details.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.model,
  });

  final PatientDataModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(PatientDetailsScreen(patientData: model));
      },
      leading: Icon(
        IconlyLight.profile,
        color: AppColors.primary,
      ),
      title: Text("${model.firstName} ${model.lastName}"),
      trailing: model.isPatientCritical == true
          ? const Icon(
              IconlyBold.danger,
              color: Colors.red,
            )
          : const SizedBox(),
    );
  }
}
