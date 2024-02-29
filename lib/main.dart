import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/config/routes/app_routes.dart';
import 'package:patient/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: AppTheme.appThemeDark(),
            theme: AppTheme.appTheme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerate,
          ),
        );
      },
    );
  }
}
