import 'package:get/get.dart';
import 'package:synctrackr/core/routes/app_routes.dart';
import 'package:synctrackr/features/approved/presentation/screens/approved_screen.dart';
import 'package:synctrackr/features/checkedout_complete/presentation/screens/checkedout_complete_screen.dart';
import 'package:synctrackr/features/checkin/presentation/screens/checkin_screen.dart';
import 'package:synctrackr/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:synctrackr/features/compliance/presentation/screens/compliance_screen.dart';
import 'package:synctrackr/features/epass/presentation/screens/e_pass_screen.dart';
import 'package:synctrackr/features/login/presentation/screens/login_Screen.dart';
import 'package:synctrackr/features/meeting_with/presentation/screens/meeting_with_screen.dart';
import 'package:synctrackr/features/mobileno/presentation/screens/mobile_no_screen.dart';
import 'package:synctrackr/features/otpverification/presentation/screens/otp_verification_screen.dart';
import 'package:synctrackr/features/profile/presentation/screens/profile_screen.dart';
import 'package:synctrackr/features/purpose_to_visit/presentation/screens/purpose_to_visit_screen.dart';
import 'package:synctrackr/features/signature/presentation/screens/signature_screen.dart';
import 'package:synctrackr/features/splash/presentation/screens/mobile_splash_screen.dart';
import 'package:synctrackr/features/uploadid/presentation/screens/upload_id_screen.dart';
import 'package:synctrackr/features/uploadphoto/presentation/screens/upload_photo_screen.dart';

class RouteGenerator {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoutes.welcome,
        page: () => const WelcomeScreen(),
      ),
      GetPage(
        name: AppRoutes.checkin,
        page: () => const CheckInScreen(),
      ),
      GetPage(
        name: AppRoutes.checkout,
        page: () => const CheckoutScreen(),
      ),
      GetPage(
        name: AppRoutes.purposetovisit,
        page: () => const PurposeToVisitScreen(),
      ),
      GetPage(
        name: AppRoutes.mobile,
        page: () => const MobileNoScreen(),
      ),
      GetPage(
        name: AppRoutes.otpverification,
        page: () => const OtpVerificationScreen(),
      ),
      GetPage(
        name: AppRoutes.profile,
        page: () => const ProfileScreen(),
      ),
      // GetPage(
      //   name: AppRoutes.uploadid,
      //   page: () => const UploadIdScreen(),
      // ),
      GetPage(
        name: AppRoutes.meetingwith,
        page: () => const MeetingWithScreen(),
      ),
      // GetPage(
      //   name: AppRoutes.uploadphoto,
      //   page: () => const UploadPhotoScreen(),
      // ),
      GetPage(
        name: AppRoutes.compliance,
        page: () => const ComplianceScreen(),
      ),
      GetPage(
        name: AppRoutes.signature,
        page: () => const SignatureScreen(),
      ),
      GetPage(
        name: AppRoutes.approved,
        page: () => const ApprovedScreen(),
      ),
      GetPage(
        name: AppRoutes.epass,
        page: () => const EPassScreen(),
      ),
      GetPage(
        name: AppRoutes.checkoutcomplete,
        page: () => const CheckedoutCompleteScreen(),
      ),
      GetPage(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
      ),
    ];
  }
}
