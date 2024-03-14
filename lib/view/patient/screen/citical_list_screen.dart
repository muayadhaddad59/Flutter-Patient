import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/view/patient/widget/patient_card.dart';

class CriticalList extends StatelessWidget {
  const CriticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: BlocBuilder<ClinicalCubit, ClinicalState>(
        builder: (context, state) {
          if (state is ClinicalIsLoadingState) {
            return const SizedBox();
          }
          if (state is ClinicalListLoadedState) {
            final data = state.model.model;
            return ListView.separated(
                itemBuilder: (context, index) =>
                    PatientCard(model: data?[index] ?? PatientDataModel()),
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemCount: state.model.model?.length ?? 0);
          }
          if (state is ClinicalErrorState) {}
          return const SizedBox();
        },
      ),
    );
  }
}
