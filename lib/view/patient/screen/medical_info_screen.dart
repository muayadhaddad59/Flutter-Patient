import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/core/utils/app_service.dart';

import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/cubit/patient_edit/patient_edit_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/insurance_emrgency_info_screen.dart';

class MedicalInfoScreen extends StatefulWidget {
  final PatientDataModel model;
  const MedicalInfoScreen({super.key, required this.model});

  @override
  State<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  final TextEditingController _purposeOfVisitController =
      TextEditingController();
  final TextEditingController _primaryCarePhysicianController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _currentMedicationsController =
      TextEditingController();
  final TextEditingController _medicalConditionController =
      TextEditingController();

  @override
  void dispose() {
    _purposeOfVisitController.dispose();
    _primaryCarePhysicianController.dispose();
    _contactNumberController.dispose();
    _allergiesController.dispose();
    _currentMedicationsController.dispose();
    _medicalConditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle("Visit Information"),
              const SizedBox(height: 10),
              _buildTextField("Purpose of Visit", _purposeOfVisitController),
              const SizedBox(height: 10),
              _buildTextField(
                  "Primary Care Physician", _primaryCarePhysicianController),
              const SizedBox(height: 10),
              _buildTextField("Contact Number", _contactNumberController),
              const SizedBox(height: 20),
              _buildSectionTitle("Medical History"),
              const SizedBox(height: 10),
              _buildTextField("Allergies", _allergiesController),
              const SizedBox(height: 10),
              _buildTextField(
                  "Current Medications", _currentMedicationsController),
              const SizedBox(height: 10),
              _buildTextField("Medical Condition", _medicalConditionController),
              20.verticalSpace,
              CustomButton(
                  label: "Next",
                  onPress: () {
                    final model = widget.model.copyFrom(PatientDataModel(
                        purposeOfVisit: _purposeOfVisitController.text,
                        primaryCarePhysician:
                            _primaryCarePhysicianController.text,
                        contactNumber: _contactNumberController.text,
                        listOfAllergies: _allergiesController.text,
                        currentMedications: _currentMedicationsController.text,
                        medicalConditions: _medicalConditionController.text));

                    context.push(BlocProvider(
                      create: (context) =>
                          sl<PatientEditCubit>(),
                      child: InsuranceInfo(model: model),
                    ));
                  }),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
