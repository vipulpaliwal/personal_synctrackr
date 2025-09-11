import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/config/session_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synctrackr/admin/screens/main_screen.dart';
import 'package:synctrackr/core/constants/app_themes.dart';
import 'package:synctrackr/core/routes/route_generator.dart';
import 'package:synctrackr/admin/routes/app_routes.dart' as adminRoutes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synctrackr',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute:  adminRoutes.adminAppRoutes.main,
      getPages: [
        ...RouteGenerator.getRoutes(),
        ...adminRoutes.adminAppRoutes.routes,
      ],
    );
  }
}

// class _SessionGate extends StatefulWidget {
//   const _SessionGate({Key? key}) : super(key: key);

//   @override
//   State<_SessionGate> createState() => _SessionGateState();
// }

// class _SessionGateState extends State<_SessionGate> {
//   final _secureStorage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     _decideStartDestination();
//   }

//   Future<void> _decideStartDestination() async {
//     try {
//       final companyId = await SessionManager.getCompanyId();
//       final token = await _secureStorage.read(key: 'authToken');

//       if (companyId != null &&
//           companyId.isNotEmpty &&
//           token != null &&
//           token.isNotEmpty) {
//         Get.offAll(() => const MainScreen());
//       } else {
//         Get.offAllNamed(adminRoutes.adminAppRoutes.adminLoginScreen);
//       }
//     } catch (_) {
//       Get.offAllNamed(adminRoutes.adminAppRoutes.adminLoginScreen);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
