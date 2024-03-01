import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';

class ClinicalDetailsInfo extends StatefulWidget {
  const ClinicalDetailsInfo({super.key});

  @override
  State<ClinicalDetailsInfo> createState() => _ClinicalDetailsInfoState();
}

class _ClinicalDetailsInfoState extends State<ClinicalDetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinical Details"),
      ),
      body: BlocBuilder<ClinicalCubit, ClinicalState>(
        builder: (context, state) {
          if (state is ClinicalIsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ClinicalLoadedState) {
            final data = state.model.model?.first ?? ClinicalDataModel();
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildDetailItem("Blood Oxygen Level", data.bloodOxygenLevel),
                _buildDetailItem("Systolic Blood Pressure", data.bpSystolic),
                _buildDetailItem("Diastolic Blood Pressure", data.bpDiastolic),
                _buildDetailItem("Respiratory Rate", data.respiratoryRate),
                _buildDetailItem("Pulse Rate", data.pulseRate),
                _buildDetailItem("Clinic Staff", data.clinicStaff),
                _buildDetailItem("Patient ID", data.patientId),
                _buildDetailItem(
                    "Critical Condition", data.isCriticalCondition),
                _buildDetailItem("Created At", data.createdAt),
                _buildDetailItem("Updated At", data.updatedAt),
              ],
            );
          }
          if (state is ClinicalErrorState) {
            return Center(
              child: Text("Error: ${state.message}"),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildDetailItem(String title, dynamic value) {
    final TextEditingController controller =
        TextEditingController(text: value != null ? value.toString() : '');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: () {
                    // Handle edit action
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: Colors.grey),
                      SizedBox(width: 4.0),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(), // Remove border
                isDense: true,
              ),
              onChanged: (newValue) {
                // Handle changes here
              },
            ),
          ),
        ],
      ),
    );
  }
}
