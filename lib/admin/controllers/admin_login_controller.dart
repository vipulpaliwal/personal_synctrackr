// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:synctrackr/admin/config/session_manager.dart';
// import 'package:synctrackr/admin/screens/main_screen.dart';
// import 'package:synctrackr/admin/services/api_services.dart';
// import 'package:synctrackr/admin/controllers/main_controller.dart';

// class AdminLoginController extends GetxController {
//   final ApiService _apiService = ApiService();
//   final _secureStorage = const FlutterSecureStorage();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   var isLoading = false.obs;
//   var emailError = ''.obs;
//   var passwordError = ''.obs;
//   var generalError = ''.obs;
//   var isPasswordVisible = false.obs;
//   var isTermsAccepted = false.obs;

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   bool _validate() {
//     bool isValid = true;
//     emailError.value = '';
//     passwordError.value = '';

//     if (emailController.text.isEmpty) {
//       emailError.value = 'Email is required';
//       isValid = false;
//     }

//     if (passwordController.text.isEmpty) {
//       passwordError.value = 'Password is required';
//       isValid = false;
//     }
//     return isValid;
//   }

// Future<void> login() async {
//   // Clear all previous errors at the beginning of a login attempt.
//   emailError.value = '';
//   passwordError.value = '';
//   generalError.value = '';

//   if (!_validate()) {
//     return;
//   }

//   isLoading.value = true;

//   try {
//     final response = await _apiService.login(
//       emailController.text.trim(),
//       passwordController.text.trim(),
//     );

//     if (response.containsKey('token') && response.containsKey('companyId')) {
//       // Success: Ensure both token and companyId are present
//       final String token = response['token'];
//       final String companyId = response['companyId'].toString();

//       await _secureStorage.write(key: 'authToken', value: token);
//       await SessionManager.saveCompanyId(companyId);
//       await SessionManager.setLoggedIn(true);
      
//       // Initialize MainController before navigation
//       Get.put(MainController());
      
//       print('Login successful. Navigating to MainScreen...');
//       Get.offAll(() => const MainScreen());
//     } else if (response.containsKey('statusCode')) {
//       // Handle specific error responses from the server
//       final statusCode = response['statusCode'];
//       final message = response['message'] ?? 'Login failed';
      
//       switch (statusCode) {
//         case 404:
//           // User not found - email doesn't exist
//           emailError.value = 'Email not found. Please check your email address.';
//           break;
//         case 401:
//           // Invalid credentials - wrong password
//           passwordError.value = 'Incorrect password. Please try again.';
//           break;
//         case 403:
//           // Account inactive
//           generalError.value = 'Your account has been deactivated. Please contact support.';
//           break;
//         case 400:
//           // Bad request - missing fields (shouldn't happen due to validation)
//           generalError.value = 'Please fill in all required fields.';
//           break;
//         case 409:
//           // 2FA required but no verified mobile
//           generalError.value = 'Two-factor authentication is enabled but no verified mobile number is on file.';
//           break;
//         default:
//           // Other server errors
//           generalError.value = message;
//       }
//       isLoading.value = false;
//     } else {
//       // Fallback for unexpected response format
//       generalError.value = response['message'] ?? 'Login failed. Please try again.';
//       isLoading.value = false;
//     }
//   } catch (e) {
//     // Network/Server connection error
//     if (e.toString().contains('Network error')) {
//       generalError.value = 'Unable to connect to the server. Please check your internet connection and try again.';
//     } else {
//       generalError.value = 'An unexpected error occurred. Please try again.';
//     }
//     isLoading.value = false;
//   }
// }

//   // @override
//   // void onClose() {
//   //   emailController.dispose();
//   //   passwordController.dispose();
//   //   super.onClose();
//   // }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synctrackr/admin/config/session_manager.dart';
import 'package:synctrackr/admin/screens/main_screen.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class AdminLoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final _secureStorage = const FlutterSecureStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var generalError = ''.obs;
  var isPasswordVisible = false.obs;
  var isTermsAccepted = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool _validate() {
    bool isValid = true;
    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    }
    return isValid;
  }

  Future<void> login() async {
    // ✅ Clear previous errors at the beginning
    emailError.value = '';
    passwordError.value = '';
    generalError.value = '';

    if (!_validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.containsKey('token')) {
        // ✅ Success
        await _secureStorage.write(key: 'authToken', value: response['token']);
        if (response.containsKey('user')) {
          final user = response['user'];
          if (user.containsKey('companyId')) {
            await SessionManager.saveCompanyId(user['companyId'].toString());
          }
          if (user.containsKey('id')) {
            await SessionManager.saveUserId(user['id'].toString());
          }
        }

        /// 🔑 FIX: Mark user as logged in
        await SessionManager.setLoggedIn(true);
         print("DEBUG: Saved Token = ${response['token']}");
  print("DEBUG: Saved CompanyId = ${response['user']['companyId']}");
  print("DEBUG: Saved UserId = ${response['user']['id']}");

        /// Navigate to MainScreen
        Get.offAll(() => const MainScreen());
      } else if (response.containsKey('statusCode')) {
        // Handle specific error responses from the server
        final statusCode = response['statusCode'];
        final message = response['message'] ?? 'Login failed';

        switch (statusCode) {
          case 404:
            emailError.value =
                'Email not found. Please check your email address.';
            break;
          case 401:
            passwordError.value = 'Incorrect password. Please try again.';
            break;
          case 403:
            generalError.value =
                'Your account has been deactivated. Please contact support.';
            break;
          case 400:
            generalError.value = 'Please fill in all required fields.';
            break;
          case 409:
            generalError.value =
                'Two-factor authentication is enabled but no verified mobile number is on file.';
            break;
          default:
            generalError.value = message;
        }
      } else {
        generalError.value =
            response['message'] ?? 'Login failed. Please try again.';
      }
    } catch (e) {
      // Network/Server connection error
      if (e.toString().contains('Network error')) {
        generalError.value =
            'Unable to connect to the server. Please check your internet connection and try again.';
      } else {
        generalError.value =
            'An unexpected error occurred. Please try again.';
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
