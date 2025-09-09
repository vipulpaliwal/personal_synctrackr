import 'package:get/get.dart';
import 'package:synctrackr/admin/screens/main_screen.dart';
import 'package:synctrackr/admin/screens/visitor_head_add_person.dart';
import 'package:synctrackr/admin/screens/visitor_head_details_screen.dart';

// ignore: camel_case_types
class adminAppRoutes {
  static const String main = '/';
  static const String visitorHeadDetails = '/visitor-head-details';
  static const String visitorsHeadAddPerson = '/visitor-head-add-person';

  static final routes = [
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(name: visitorHeadDetails, page: () => VisitorHeadDetailsScreen()),
    GetPage(name: visitorsHeadAddPerson, page: () => VisitorHeadAddPerson()),
  ];
}
