import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/core/constants/app_themes.dart';
import 'package:synctrackr/core/routes/route_generator.dart';
import 'package:synctrackr/admin/routes/app_routes.dart' as adminRoutes;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synctrackr',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: adminRoutes.adminAppRoutes.main,
      getPages: [
        ...RouteGenerator.getRoutes(),
        ...adminRoutes.adminAppRoutes.routes,
      ],
    );
  }
}
