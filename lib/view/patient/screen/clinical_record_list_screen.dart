import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/core/utils/app_service.dart';
import 'package:patient/core/utils/navigator_extension.dart';
import 'package:patient/data/clinical/model/clinical_model.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/provider/clinicalCubit/clinical_edit/clinical_edit_cubit.dart';
import 'package:patient/view/patient/screen/add_clinical_record_screen.dart';
import 'package:patient/view/patient/screen/clinical_details_screen.dart';
import 'package:intl/intl.dart';

class ClinicalRecordListScreen extends StatelessWidget {
  final String patientID;
  const ClinicalRecordListScreen({super.key, required this.patientID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          context.push(BlocProvider(
            create: (context) => sl<ClinicalEditCubit>(),
            child: AddClinicalScreen(patientID: patientID),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text("Clinical Record"),
      ),
      body: BlocBuilder<ClinicalCubit, ClinicalState>(
        builder: (context, state) {
          if (state is ClinicalIsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ClinicalLoadedState) {
            final data = state.model.model;
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ClinicalCubit>()
                    .getClinical(ClinicalDataModel(sId: patientID));
              },
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final model = data?[index];
                    return ListTile(
                      onTap: () {
                        context.push(ClinicalDetailsInfo(
                          model: model!,
                        ));
                      },
                      title: Text(DateFormat.yMMMd()
                          .add_jm()
                          .format(DateTime.parse(model?.createdAt ?? ""))),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: data?.length ?? 0),
            );
          }
          if (state is ClinicalErrorState) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
