import 'package:get/get.dart';
import 'package:synctrackr/admin/screens/admin_login_screen.dart';
import 'package:synctrackr/admin/screens/main_screen.dart';
import 'package:synctrackr/admin/screens/visitor_head_add_person.dart';
import 'package:synctrackr/admin/screens/visitor_head_details_screen.dart';
import 'package:synctrackr/admin/screens/admin_mobile_no_screen.dart';
import 'package:synctrackr/admin/screens/admin_otp_verification_screen.dart';
import 'package:synctrackr/admin/screens/checkedout_complete.dart';

// ignore: camel_case_types
class adminAppRoutes {
  static const String main = '/';
  static const String visitorHeadDetails = '/visitor-head-details';
  static const String visitorsHeadAddPerson = '/visitor-head-add-person';
  static const String adminLoginScreen = '/admin-login-screen';
  static const String adminMobileNoScreen = '/admin-mobile-no-screen';
  static const String adminOtpVerificationScreen =
      '/admin-otp-verification-screen';
  static const String manualCheckoutComplete = '/manual-checkout-complete';

  static final routes = [
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(name: visitorHeadDetails, page: () => VisitorHeadDetailsScreen()),
    GetPage(name: visitorsHeadAddPerson, page: () => VisitorHeadAddPerson()),
    GetPage(name: adminLoginScreen, page: () => AdminLoginScreen()),
    GetPage(name: adminMobileNoScreen, page: () => const AdminMobileNoScreen()),
    GetPage(
        name: adminOtpVerificationScreen,
        page: () => const AdminOtpVerificationScreen()),
    GetPage(
        name: manualCheckoutComplete, page: () => const ManualCheckOutScreen()),
  ];
}
