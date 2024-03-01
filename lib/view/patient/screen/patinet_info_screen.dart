import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/medical_info_screen.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _provinceCtrl = TextEditingController();
  final _postalCodeCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _contactNumberCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _idNumberCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _dobCtrl.dispose();
    _ageCtrl.dispose();
    _genderCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _provinceCtrl.dispose();
    _postalCodeCtrl.dispose();
    _addressCtrl.dispose();
    _contactNumberCtrl.dispose();
    _emailCtrl.dispose();
    _idNumberCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Info"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              SizedBox(height: 20.h),
              _buildTextField(label: "First Name", controller: _firstNameCtrl),
              SizedBox(height: 10.h),
              _buildTextField(label: "Last Name", controller: _lastNameCtrl),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        label: "Date of Birth", controller: _dobCtrl),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(label: "Age", controller: _ageCtrl),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                        label: "Gender", controller: _genderCtrl),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        label: "Height", controller: _heightCtrl),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                        label: "Weight", controller: _weightCtrl),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        label: "Province", controller: _provinceCtrl),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                        label: "Postal Code", controller: _postalCodeCtrl),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildTextField(label: "Address", controller: _addressCtrl),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        label: "Contact Number",
                        controller: _contactNumberCtrl),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child:
                        _buildTextField(label: "Email", controller: _emailCtrl),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildTextField(label: "ID Number", controller: _idNumberCtrl),
              SizedBox(height: 20.h),
              CustomButton(
                  label: "Next",
                  onPress: () {
                    final model = PatientDataModel(
                        firstName: _firstNameCtrl.text,
                        lastName: _lastNameCtrl.text,
                        dateOfBirth: _dobCtrl.text,
                        age: int.parse(_ageCtrl.text),
                        gender: _genderCtrl.text,
                        height: int.tryParse(_heightCtrl.text),
                        weight: int.parse(_weightCtrl.text),
                        province: _provinceCtrl.text,
                        postalCode: _postalCodeCtrl.text,
                        contactNumber: _contactNumberCtrl.text,
                        email: _emailCtrl.text,
                        identification: _idNumberCtrl.text);
                    context.push(MedicalInfoScreen(
                      model: model,
                    ));
                  }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
