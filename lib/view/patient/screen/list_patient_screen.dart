import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/cubit/patient/patient_cubit.dart';

class ListPatientScreen extends StatefulWidget {
  const ListPatientScreen({super.key});

  @override
  State<ListPatientScreen> createState() => _ListPatientScreenState();
}

class _ListPatientScreenState extends State<ListPatientScreen> {
  List<PatientDataModel> data = [];

  List<PatientDataModel> searchResults = [];

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((item) =>
              item.firstName!.toLowerCase().contains(query.toLowerCase()) ||
              item.lastName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List of patients",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0).w,
        child: Column(
          children: [
            _textFiled(),
            Expanded(
              child: BlocListener<PatientCubit, PatientState>(
                listener: (context, state) {
                  if (state is PatientLoadedState) {
                    searchResults = state.model.model ?? [];
                  }
                },
                child: BlocBuilder<PatientCubit, PatientState>(
                  builder: (context, state) {
                    if (state is PatientIsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is PatientLoadedState) {
                      final dataAPi = state.model.model;
                      data = dataAPi ?? [];

                      return ListView.separated(
                          itemBuilder: (context, index) {
                            final model = searchResults[index];
                            return ListTile(
                              leading: Icon(
                                IconlyLight.profile,
                                color: AppColors.primary,
                              ),
                              title:
                                  Text("${model.firstName} ${model.lastName}"),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              10.verticalSpace,
                          itemCount: searchResults.length);
                    }
                    if (state is PatientErrorState) {}
                    return const SizedBox();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField _textFiled() {
    return TextField(
      onChanged: onQueryChanged,
      decoration: InputDecoration(
          hintText: "Search for a patient...",
          fillColor: AppColors.bg,
          filled: true,
          prefixIcon: const Icon(Icons.search),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300))),
    );
  }
}
