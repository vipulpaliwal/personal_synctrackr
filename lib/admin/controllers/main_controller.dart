import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_heads_model.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/screens/checkout_screen.dart';
import 'package:synctrackr/admin/screens/dashboard_screen.dart';
import 'package:synctrackr/admin/screens/others_checkIN_screen.dart';
import 'package:synctrackr/admin/screens/others_compliance_screen.dart';
import 'package:synctrackr/admin/screens/others_epass_generator_screen.dart';
import 'package:synctrackr/admin/screens/others_screen.dart';
import 'package:synctrackr/admin/screens/reports_screen.dart';
import 'package:synctrackr/admin/screens/reports_view_screen.dart';
import 'package:synctrackr/admin/screens/setting_screen.dart';
import 'package:synctrackr/admin/screens/setting_upgrade_plan_screen.dart';
import 'package:synctrackr/admin/screens/visitor_details.dart';
import 'package:synctrackr/admin/screens/visitor_head_add_person.dart';
import 'package:synctrackr/admin/screens/visitor_head_details_screen.dart';
import 'package:synctrackr/admin/screens/visitor_head_update_person.dart';
import 'package:synctrackr/admin/screens/visitors.dart';
import 'package:synctrackr/admin/screens/visitors_heads_screen.dart';
import 'package:synctrackr/admin/utils/responsive.dart';
import 'dart:async'; // Added for Timer

class MainController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  late PageController pageController;
  final RxInt _selectedIndex = 0.obs;
  final Rx<Visitor?> _selectedVisitor = Rx<Visitor?>(null);
  final Rx<Employee?> _selectedEmployee = Rx<Employee?>(null);
  final Rx<String?> _selectedMonth = Rx<String?>(null);
  final RxBool isNotificationVisible = false.obs;
  final RxBool isDarkMode = false.obs;
  final RxBool _lastSystemTheme = false.obs; // Track last detected system theme
  Timer? _themeTimer; // Timer for theme monitoring

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    // Automatically detect system theme and set initial theme
    _detectSystemTheme();

    // Periodically check for system theme changes
    _startThemeMonitoring();
  }

  /// Detects the system theme and sets the initial theme state
  void _detectSystemTheme() {
    try {
      // Get the current system theme mode
      final brightness = MediaQuery.of(Get.context!).platformBrightness;
      final isSystemDark = brightness == Brightness.dark;

      // Track the last detected system theme
      _lastSystemTheme.value = isSystemDark;

      // Set the initial theme based on system preference
      isDarkMode.value = isSystemDark;

      print('🔄 System theme detected: ${isSystemDark ? "Dark" : "Light"}');
    } catch (e) {
      // Fallback to light theme if detection fails
      isDarkMode.value = false;
      _lastSystemTheme.value = false;
      print('⚠️ System theme detection failed, defaulting to light theme');
    }
  }

  /// Manually refresh system theme detection
  void refreshSystemTheme() {
    _detectSystemTheme();
  }

  /// Check if current theme matches system theme
  bool get isThemeMatchingSystem {
    try {
      final brightness = MediaQuery.of(Get.context!).platformBrightness;
      final isSystemDark = brightness == Brightness.dark;
      return isDarkMode.value == isSystemDark;
    } catch (e) {
      return false;
    }
  }

  /// Reset theme to match system preference
  void resetToSystemTheme() {
    _detectSystemTheme();
  }

  /// Toggle between current theme and system theme
  void toggleToSystemTheme() {
    if (isThemeMatchingSystem) {
      // If already matching system, toggle to opposite
      toggleTheme();
    } else {
      // If not matching system, reset to system theme
      resetToSystemTheme();
    }
  }

  /// Get current system theme as string
  String get systemThemeName {
    try {
      final brightness = MediaQuery.of(Get.context!).platformBrightness;
      return brightness == Brightness.dark ? "Dark" : "Light";
    } catch (e) {
      return "Light";
    }
  }

  /// Check if system theme has changed since last detection
  bool get hasSystemThemeChanged {
    try {
      final brightness = MediaQuery.of(Get.context!).platformBrightness;
      final currentSystemTheme = brightness == Brightness.dark;
      return currentSystemTheme != _lastSystemTheme.value;
    } catch (e) {
      return false;
    }
  }

  /// Auto-sync with system theme changes
  void autoSyncWithSystemTheme() {
    if (hasSystemThemeChanged) {
      _detectSystemTheme();
      print('🔄 Auto-synced with system theme change');
    }
  }

  /// Start monitoring for system theme changes
  void _startThemeMonitoring() {
    // Check for theme changes every 2 seconds
    _themeTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (hasSystemThemeChanged) {
        autoSyncWithSystemTheme();
      }
    });
  }

  /// Get theme status information
  Map<String, dynamic> get themeStatus {
    return {
      'currentTheme': isDarkMode.value ? 'Dark' : 'Light',
      'systemTheme': systemThemeName,
      'isMatchingSystem': isThemeMatchingSystem,
      'hasChanged': hasSystemThemeChanged,
    };
  }

  /// Get user-friendly theme description
  String get themeDescription {
    if (isThemeMatchingSystem) {
      return 'Using system theme ($systemThemeName)';
    } else {
      final currentTheme = isDarkMode.value ? 'Dark' : 'Light';
      final systemTheme = systemThemeName;
      return 'Custom theme: $currentTheme (System: $systemTheme)';
    }
  }

  int get selectedIndex => _selectedIndex.value;
  Visitor? get selectedVisitor => _selectedVisitor.value;
  String? get selectedMonth => _selectedMonth.value;
  Employee? get selectedEmployee => _selectedEmployee.value;

  final DashboardScreen _dashboardScreen = DashboardScreen();

  List<Widget> get screens => [
        _dashboardScreen,
        const VisitorsScreen(),
        VisitorsHeadsScreen(),
        ReportsScreen(),
        OthersScreen(),
        SettingsScreen(),
        const VisitorHeadDetailsScreen(),
        VisitorHeadAddPerson(),
        ReportsViewScreen(),
        selectedVisitor != null
            ? VisitorDetailsScreen(visitorId: selectedVisitor!.id)
            : Container(),
        OthersCheckinScreen(),
        OthersComplianceScreen(),
        OthersEpassGenerator(),
        UpgradePlan(),
        CheckoutScreen(),
        _buildVisitorHeadUpdatePerson()
      ];

  void selectScreen(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
    if (Get.context != null && Responsive.isMobile(Get.context!)) {
      Get.back(); // Close drawer
    }
  }

  void selectEmployee(Employee employee) {
    _selectedEmployee.value = employee;
    _selectedVisitor.value = null; // Clear other selection
    update(); // Notify listeners to rebuild
  }

  void selectVisitorHead(Employee employee) {
    _selectedEmployee.value = employee;
    _selectedIndex.value = 6;
  }

  void selectAddVisitorHead() {
    _selectedIndex.value = 7;
  }

  void selectReportsView(String month) {
    _selectedMonth.value = month;
    _selectedIndex.value = 8;
  }

  void selectVisitor(Visitor visitor) {
    _selectedVisitor.value = visitor;
    _selectedEmployee.value = null; // Clear other selection
    _selectedIndex.value = 9;
  }

  void othersCheckinScreen() {
    _selectedIndex.value = 10;
  }

  void othersComplianceScreen() {
    _selectedIndex.value = 11;
  }

  void othersEpassGenerator() {
    _selectedIndex.value = 12;
  }

  void upgradePlan() {
    _selectedIndex.value = 13;
  }

  void checkoutScreen() {
    _selectedIndex.value = 14;
  }

  void visitorHeadUpdatePerson(Employee employee) {
    _selectedEmployee.value = employee;
    _selectedIndex.value = 15;
  }

  Widget _buildVisitorHeadUpdatePerson() {
    final headId = _selectedEmployee.value?.id;
    if (headId == null || headId.isEmpty || headId == '0') {
      return Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No Employee Selected',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Please select an employee from the visitor heads list to update their profile.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }
    return VisitorHeadUpdatePerson(headId: headId);
  }

  void openDrawer() {
    if (_scaffoldKey.currentState != null &&
        !_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  @override
  void onClose() {
    _themeTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
