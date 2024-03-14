import 'package:flutter/material.dart';
import 'package:patient/data/patient/model/patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key, required PatientDataModel patientData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
    );
  }
}
