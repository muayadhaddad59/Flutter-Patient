import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/routes/app_routes.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/core/utils/navigator_extension.dart';

//app home screen with search, nav bar, list, and add new patient option
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeCare Patient Management",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            50.verticalSpace,
            _textFiled(),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        label: "New Patient",
                        onPress: () {
                          context.pushNamed(Routes.addPatient);
                        })),
                20.horizontalSpace,
                Expanded(
                    child: CustomButton(
                        label: "List all patient",
                        onPress: () {
                          context.pushNamed(Routes.patientList);
                        })),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card _textFiled() {
    return Card(
      elevation: 5,
      color: AppColors.bg,
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search for a patient...",
            fillColor: AppColors.bg,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }

  Text _headerText() {
    return Text.rich(TextSpan(
        text: "Hello,",
        style: TextStyle(color: AppColors.primary, fontSize: 22.sp),
        children: const [
          TextSpan(
              text: "\nClinic Staff!",
              style: TextStyle(fontWeight: FontWeight.w700))
        ]));
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback onPress;
  final Size? size;

  const CustomButton({
    super.key,
    required this.label,
    this.color,
    required this.onPress,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          fixedSize: size ?? Size.fromHeight(40.sp),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: color ?? AppColors.primary.withOpacity(0.6)),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
