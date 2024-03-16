import 'package:flutter/material.dart';
import 'package:patient/core/utils/helper_method.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';

class ClinicalDetailsInfo extends StatefulWidget {
  final ClinicalDataModel model;
  const ClinicalDetailsInfo({super.key, required this.model});

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
    bloodOxygenLevelCtrl =
        TextEditingController(text: widget.model.bloodOxygenLevel.toString());
    systolicBloodPressureCtrl =
        TextEditingController(text: widget.model.bpSystolic.toString());
    diastolicBloodPressureCtrl =
        TextEditingController(text: widget.model.bpDiastolic.toString());
    respiratoryRateCtrl =
        TextEditingController(text: widget.model.respiratoryRate.toString());
    pulseRateCtrl =
        TextEditingController(text: widget.model.pulseRate.toString());
    criticalConditionCtrl = TextEditingController(
        text: widget.model.isCriticalCondition.toString());
  }

  @override
  Widget build(BuildContext context) {
    return HelperMethod.loader(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Clinical Details"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  
                  _buildDetailItem(
                      "Systolic Blood Pressure", systolicBloodPressureCtrl),
                  _buildDetailItem(
                      "Diastolic Blood Pressure", diastolicBloodPressureCtrl),
                  _buildDetailItem("Respiratory Rate", respiratoryRateCtrl),
                  _buildDetailItem("Blood Oxygen Level", bloodOxygenLevelCtrl),
                  _buildDetailItem("Pulse Rate", pulseRateCtrl),

                  const SizedBox(height: 50), // Use SizedBox for spacing
                  // CustomButton(
                  //   label: "Edit",
                  //   onPress: () {
                  //     context
                  //         .read<ClinicalEditCubit>()
                  //         .updateClinical(ClinicalDataModel(
                  //           bpSystolic:
                  //               int.tryParse(systolicBloodPressureCtrl.text),
                  //           bpDiastolic:
                  //               int.tryParse(diastolicBloodPressureCtrl.text),
                  //           respiratoryRate:
                  //               int.tryParse(respiratoryRateCtrl.text),
                  //           bloodOxygenLevel:
                  //               int.tryParse(bloodOxygenLevelCtrl.text),
                  //           pulseRate: int.tryParse(pulseRateCtrl.text),
                  //           isCriticalCondition:
                  //               criticalConditionCtrl.text == "true"
                  //                   ? true
                  //                   : false,
                  //         ));
                  //   },
                  //   size: Size(0.8.sw, 40.sp),
                  // ),
                ],
              ),
            ),
          )),
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
