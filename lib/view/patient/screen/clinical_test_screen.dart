import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/medical_info_screen.dart';

class ClinicalTestScreen extends StatefulWidget {
  const ClinicalTestScreen({super.key});

  @override
  State<ClinicalTestScreen> createState() => ClinicalTestScreenState();
}

class ClinicalTestScreenState extends State<ClinicalTestScreen> {
  final TextEditingController _bloodPressureController =
      TextEditingController();
  final TextEditingController _respiratoryRateController =
      TextEditingController();
  final TextEditingController _bloodOxygenController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _attendingStaffController =
      TextEditingController();

  @override
  void dispose() {
    _bloodPressureController.dispose();
    _respiratoryRateController.dispose();
    _bloodOxygenController.dispose();
    _heartRateController.dispose();
    _attendingStaffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinical Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField("Blood Pressure", "Systolic/Diastolic mm Hg",
                  _bloodPressureController),
              const SizedBox(height: 10),
              _buildTextField("Respiratory Rate", "Breaths per Minute",
                  _respiratoryRateController),
              const SizedBox(height: 10),
              _buildTextField("Blood Oxygen", "%", _bloodOxygenController),
              const SizedBox(height: 10),
              _buildTextField(
                  "Heart Rate", "Beats per Minute", _heartRateController),
              const SizedBox(height: 10),
              _buildTextField("Attending Clinical Staff",
                  "Name of Clinical Staff", _attendingStaffController),
              20.verticalSpace,
              CustomButton(
                  label: "Save",
                  onPress: () {
                    final model = PatientDataModel();
                    context.push(MedicalInfoScreen(model: model));
                  }),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String title, String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: hintText,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
