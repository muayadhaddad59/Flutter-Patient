import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/data/patient/model/patient_model.dart';
import 'package:patient/provider/patinetcubit/patient/patient_cubit.dart';
import 'package:patient/view/patient/widget/patient_card.dart';

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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchTextField(),
            SizedBox(height: 16.h),
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
                      final dataAPI = state.model.model;
                      data = dataAPI ?? [];
                      return _buildPatientList();
                    }
                    if (state is PatientErrorState) {
                      return const Center(
                          child: Text("Error loading patients"));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      onChanged: onQueryChanged,
      decoration: InputDecoration(
        hintText: "Search for a patient...",
        fillColor: AppColors.bg,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildPatientList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final model = searchResults[index];
        return PatientCard(model: model);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemCount: searchResults.length,
    );
  }
}
