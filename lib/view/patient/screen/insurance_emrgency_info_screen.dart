import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient/core/utils/app_service.dart';
import 'package:patient/core/utils/helper_method.dart';

import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/clinicalCubit/clinical_edit/clinical_edit_cubit.dart';

import 'package:patient/provider/patinetcubit/patient_edit/patient_edit_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/clinical_test_screen.dart';
import 'package:toastification/toastification.dart';

class InsuranceInfo extends StatefulWidget {
  final PatientDataModel model;
  const InsuranceInfo({super.key, required this.model});

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
    return HelperMethod.loader(
      child: Scaffold(
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
                BlocListener<PatientEditCubit, PatientEditState>(
                  listener: (context, state) {
                    if (state is PatientEditIsLoadingState) {
                      context.loaderOverlay.show();
                    }
                    if (state is PatientEditSuccessState) {
                      context.loaderOverlay.hide();
                      HelperMethod.showToast(context,
                          title: const Text("Created Successfully"),
                          type: ToastificationType.success);
                      context.push(BlocProvider(
                        create: (context) => sl<ClinicalEditCubit>(),
                        child: ClinicalTestScreen(
                          pID: state.model?.sId ?? "",
                        ),
                      ));
                    }
                    if (state is PatientEditErrorState) {
                      context.loaderOverlay.hide();
                      HelperMethod.showToast(context,
                          title: Text(state.message),
                          type: ToastificationType.error);
                    }
                  },
                  child: CustomButton(
                      label: "Save & Add Clincal Test",
                      onPress: () {
                        // print(widget.model.firstName);
                        final model = widget.model.copyFrom(PatientDataModel(
                            insuranceProvider:
                                _insuranceProviderController.text,
                            insuranceIdNumber: _insuranceIdController.text,
                            insuranceContactNumber:
                                _insuranceContactNumberController.text,
                            emergencyContactPerson:
                                _emergencyContactPersonController.text,
                            emergencyContactNumber:
                                _emergencyContactNumberController.text));
                        context.read<PatientEditCubit>().addPatient(model);
                      }),
                ),
                20.verticalSpace,
              ],
            ),
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
