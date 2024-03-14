import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/provider/clinicalCubit/clinical_edit/clinical_edit_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:toastification/toastification.dart';

class ClinicalDetailsInfo extends StatefulWidget {
  const ClinicalDetailsInfo({super.key});

  @override
  State<ClinicalDetailsInfo> createState() => _ClinicalDetailsInfoState();
}

class _ClinicalDetailsInfoState extends State<ClinicalDetailsInfo> {
  late TextEditingController bloodOxygenLevelCtrl;
  late TextEditingController systolicBloodPressureCtrl;
  late TextEditingController diastolicBloodPressureCtrl;
  late TextEditingController respiratoryRateCtrl;
  late TextEditingController pulseRateCtrl;
  late TextEditingController criticalConditionCtrl;

  @override
  void initState() {
    super.initState();
    bloodOxygenLevelCtrl = TextEditingController();
    systolicBloodPressureCtrl = TextEditingController();
    diastolicBloodPressureCtrl = TextEditingController();
    respiratoryRateCtrl = TextEditingController();
    pulseRateCtrl = TextEditingController();
    criticalConditionCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return HelperMethod.loader(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Clinical Details"),
        ),
        body: BlocListener<ClinicalEditCubit, ClinicalEditState>(
          listener: (context, state) {
            if (state is ClinicalEditIsLoadingState) {
              context.loaderOverlay.show();
            }
            if (state is ClinicalEditSuccessState) {
              context.loaderOverlay.hide();
              HelperMethod.showToast(context,
                  title: const Text("Data updated successfully"),
                  type: ToastificationType.success);
            }
            if (state is ClinicalEditErrorState) {
              context.loaderOverlay.hide();
              HelperMethod.showToast(context,
                  title: Text(state.message), type: ToastificationType.error);
            }
          },
          child: BlocBuilder<ClinicalCubit, ClinicalState>(
            builder: (context, state) {
              if (state is ClinicalIsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ClinicalLoadedState) {
                final data = state.model.model?.first ?? ClinicalDataModel();
                // Assign values from data to controllers
                bloodOxygenLevelCtrl.text = data.bloodOxygenLevel.toString();
                systolicBloodPressureCtrl.text = data.bpSystolic.toString();
                diastolicBloodPressureCtrl.text = data.bpDiastolic.toString();
                respiratoryRateCtrl.text = data.respiratoryRate.toString();
                pulseRateCtrl.text = data.pulseRate.toString();
                criticalConditionCtrl.text =
                    data.isCriticalCondition.toString();

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDetailItem(
                            "Blood Oxygen Level", bloodOxygenLevelCtrl),
                        _buildDetailItem("Systolic Blood Pressure",
                            systolicBloodPressureCtrl),
                        _buildDetailItem("Diastolic Blood Pressure",
                            diastolicBloodPressureCtrl),
                        _buildDetailItem(
                            "Respiratory Rate", respiratoryRateCtrl),
                        _buildDetailItem("Pulse Rate", pulseRateCtrl),

                        const SizedBox(height: 50), // Use SizedBox for spacing
                        CustomButton(
                          label: "Edit",
                          onPress: () {
                            context
                                .read<ClinicalEditCubit>()
                                .updateClinical(ClinicalDataModel(
                                  patientId: data.patientId,
                                  bpSystolic: int.tryParse(
                                      systolicBloodPressureCtrl.text),
                                  bpDiastolic: int.tryParse(
                                      diastolicBloodPressureCtrl.text),
                                  respiratoryRate:
                                      int.tryParse(respiratoryRateCtrl.text),
                                  bloodOxygenLevel:
                                      int.tryParse(bloodOxygenLevelCtrl.text),
                                  pulseRate: int.tryParse(pulseRateCtrl.text),
                                  isCriticalCondition:
                                      criticalConditionCtrl.text == "true"
                                          ? true
                                          : false,
                                ));
                          },
                          size: Size(0.8.sw, 40.sp),
                        ),
                      ],
                    ),
                  ),
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
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, TextEditingController ctrl) {
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
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: TextField(
              controller: ctrl,
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
