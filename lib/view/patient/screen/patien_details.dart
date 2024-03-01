import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/core/utils/app_service.dart';
import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/clinical_details_screen.dart';

class PatientDetailsScreen extends StatefulWidget {
  final PatientDataModel patientData;

  const PatientDetailsScreen({super.key, required this.patientData});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late PatientDataModel _editedPatientData;

  @override
  void initState() {
    super.initState();
    _editedPatientData = widget.patientData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPersonalInfoCard(),
              const SizedBox(height: 16.0),
              _buildSectionTitle("Medical Information"),
              _buildDetailItem(Icons.work, "Purpose of Visit",
                  _editedPatientData.purposeOfVisit ?? ''),
              _buildDetailItem(Icons.medical_services, "Primary Care Physician",
                  _editedPatientData.primaryCarePhysician ?? ''),
              _buildDetailItem(Icons.phone_in_talk, "Physician Contact Number",
                  _editedPatientData.physicianContactNumber ?? ''),
              _buildDetailItem(Icons.medical_services, "List of Allergies",
                  _editedPatientData.listOfAllergies ?? ''),
              _buildDetailItem(Icons.medical_services, "Current Medications",
                  _editedPatientData.currentMedications ?? ''),
              _buildDetailItem(Icons.medical_services, "Medical Conditions",
                  _editedPatientData.medicalConditions ?? ''),
              _buildDetailItem(Icons.medical_services, "Insurance Provider",
                  _editedPatientData.insuranceProvider ?? ''),
              _buildDetailItem(Icons.credit_card, "Insurance ID Number",
                  _editedPatientData.insuranceIdNumber ?? ''),
              _buildDetailItem(Icons.phone, "Insurance Contact Number",
                  _editedPatientData.insuranceContactNumber ?? ''),
              const SizedBox(height: 16.0),
              _buildSectionTitle("Medical History"),
              _buildDetailItem(Icons.person, "Emergency Contact Person",
                  _editedPatientData.emergencyContactPerson ?? ''),
              _buildDetailItem(Icons.phone, "Emergency Contact Number",
                  _editedPatientData.emergencyContactNumber ?? ''),
              20.verticalSpace,
              CustomButton(
                  size: Size(0.9.sw, 45.sp),
                  label: "Clinical Details",
                  onPress: () {
                    context.push(BlocProvider(
                      create: (context) => sl<ClinicalCubit>()
                        ..getClinical(
                            ClinicalDataModel(sId: _editedPatientData.sId)),
                      child: const ClinicalDetailsInfo(),
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Personal Information"),
            _buildDetailItem(Icons.person, "Patient Name",
                "${_editedPatientData.firstName ?? ''} ${_editedPatientData.lastName ?? ''}"),
            _buildDetailItem(Icons.calendar_today, "Date of Birth",
                _editedPatientData.dateOfBirth ?? ''),
            _buildDetailItem(
                Icons.cake, "Age", "${_editedPatientData.age ?? ''}"),
            _buildDetailItem(
                Icons.wc, "Gender", _editedPatientData.gender ?? ''),
            _buildDetailItem(
                Icons.height, "Height", "${_editedPatientData.height ?? ''}"),
            _buildDetailItem(Icons.monitor_weight, "Weight",
                "${_editedPatientData.weight ?? ''}"),
            _buildDetailItem(
                Icons.location_on, "Address", _editedPatientData.address ?? ''),
            _buildDetailItem(
                Icons.location_city, "City", _editedPatientData.city ?? ''),
            _buildDetailItem(Icons.location_city, "Province",
                _editedPatientData.province ?? ''),
            _buildDetailItem(Icons.location_pin, "Postal Code",
                _editedPatientData.postalCode ?? ''),
            _buildDetailItem(Icons.phone, "Contact Number",
                _editedPatientData.contactNumber ?? ''),
            _buildDetailItem(
                Icons.email, "Email", _editedPatientData.email ?? ''),
            _buildDetailItem(Icons.credit_card, "Identification",
                _editedPatientData.identification ?? ''),
            _buildDetailItem(Icons.perm_identity, "Identification Type",
                _editedPatientData.identificationType ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData iconData, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: Colors.grey[600], size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
