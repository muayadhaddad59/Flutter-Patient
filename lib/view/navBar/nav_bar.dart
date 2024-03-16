import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/core/utils/app_service.dart';
import 'package:patient/provider/clinicalCubit/clinical/clinical_cubit.dart';
import 'package:patient/provider/patinetcubit/patient/patient_cubit.dart';
import 'package:patient/view/home/screen/home_screen.dart';
import 'package:patient/view/patient/screen/citical_list_screen.dart';
import 'package:patient/view/patient/screen/list_patient_screen.dart';
import 'package:patient/view/patient/screen/patinet_info_screen.dart';

enum _SelectedTab { home, favorite, add, search }

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var _selectedTab = _SelectedTab.home;
  var _currentIndex = 0;
  final _screens = [
    const HomeScreen(), // home screen
    BlocProvider(
      // Critical
      create: (context) => sl<ClinicalCubit>()..getListCritical(),
      child: const CriticalList(),
    ),
    const AddPatientScreen(), // placeholder for add patient
    BlocProvider(
      create: (context) => sl<PatientCubit>()..getPatient(),
      child: const ListPatientScreen(),
    ) // placeholder for list all patient
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      if (_currentIndex != i) {
        _currentIndex = i;
        // Pop screens until only one screen
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        _selectedTab = _SelectedTab.values[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedTab.index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          height: 10,
          // indicatorColor: Colors.blue,
          unselectedItemColor: Colors.white70,
          backgroundColor: AppColors.primary,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),

            /// critical patients
            CrystalNavigationBarItem(
              icon: IconlyBold.danger,
              unselectedIcon: IconlyLight.danger,
              selectedColor: Colors.red,
            ),

            /// add new patient
            CrystalNavigationBarItem(
              icon: IconlyBold.plus,
              unselectedIcon: IconlyLight.plus,
              selectedColor: Colors.white,
            ),

            /// list all patients
            CrystalNavigationBarItem(
              icon: IconlyBold.user_2,
              unselectedIcon: IconlyLight.user,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
