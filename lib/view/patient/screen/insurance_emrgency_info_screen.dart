import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/routes/app_routes.dart';
import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/view/home/screen/home_screen.dart';

class InsuranceInfo extends StatefulWidget {
  const InsuranceInfo({super.key});

  @override
  State<InsuranceInfo> createState() => InsuranceInfoState();
}

class InsuranceInfoState extends State<InsuranceInfo> {
  final TextEditingController _insuranceProviderController =
      TextEditingController();
  final TextEditingController _insuranceIdController = TextEditingController();
  final TextEditingController _insuranceContactNumberController =
      TextEditingController();
  final TextEditingController _emergencyContactPersonController =
      TextEditingController();
  final TextEditingController _emergencyContactNumberController =
      TextEditingController();

  @override
  void dispose() {
    _insuranceProviderController.dispose();
    _insuranceIdController.dispose();
    _insuranceContactNumberController.dispose();
    _emergencyContactPersonController.dispose();
    _emergencyContactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insurance Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle("Insurance Information"),
              const SizedBox(height: 10),
              _buildTextField(
                  "Insurance Provider", _insuranceProviderController),
              const SizedBox(height: 10),
              _buildTextField("Insurance ID Number", _insuranceIdController),
              const SizedBox(height: 10),
              _buildTextField("Insurance Contact Number",
                  _insuranceContactNumberController),
              const SizedBox(height: 20),
              _buildSectionTitle("Emergency Contact Details"),
              const SizedBox(height: 10),
              _buildTextField("Emergency Contact Person",
                  _emergencyContactPersonController),
              const SizedBox(height: 10),
              _buildTextField("Emergency Contact Number",
                  _emergencyContactNumberController),
              20.verticalSpace,
              CustomButton(
                  label: "Save",
                  onPress: () {
                    context.pushNamed(Routes.addMedicalInfoScreen);
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
