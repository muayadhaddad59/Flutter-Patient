import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/provider/clinicalCubit/clinical_edit/clinical_edit_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/navBar/nav_bar.dart';
import 'package:toastification/toastification.dart';

class ClinicalTestScreen extends StatefulWidget {
  final String pID;
  const ClinicalTestScreen({super.key, required this.pID});

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
    return HelperMethod.loader(
      child: Scaffold(
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
                BlocListener<ClinicalEditCubit, ClinicalEditState>(
                  listener: (context, state) {
                    if (state is ClinicalEditIsLoadingState) {
                      context.loaderOverlay.show();
                    }
                    if (state is ClinicalEditSuccessState) {
                      context.loaderOverlay.hide();
                      HelperMethod.showToast(context,
                          title: const Text("Created Successfully"),
                          type: ToastificationType.success);
                      context.pushReplacement(const NavBar());
                    }
                    if (state is ClinicalEditErrorState) {
                      context.loaderOverlay.hide();
                      HelperMethod.showToast(context,
                          title: Text(state.message),
                          type: ToastificationType.error);
                    }
                  },
                  child: CustomButton(
                      label: "Save",
                      onPress: () {
                        final model = ClinicalDataModel(
                            patientId: widget.pID,
                            pulseRate: int.parse(_heartRateController.text),
                            respiratoryRate:
                                int.parse(_respiratoryRateController.text),
                            bloodOxygenLevel:
                                int.parse(_bloodOxygenController.text),
                            clinicStaff: _attendingStaffController.text,
                            bpDiastolic:
                                int.parse(_bloodPressureController.text),
                            bpSystolic:
                                int.parse(_bloodPressureController.text));
                        context.read<ClinicalEditCubit>().addClinical(model);
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
