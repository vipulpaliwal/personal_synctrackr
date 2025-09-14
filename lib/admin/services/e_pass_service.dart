




// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:synctrackr/admin/config/api_config.dart';
// import 'package:synctrackr/admin/config/session_manager.dart';

// class EPassService {
//   static const _secureStorage = FlutterSecureStorage();

//   static Future<Map<String, dynamic>> createPass({
//     required String fullName,
//     required String email,
//     String? department,
//     String? designation,
//     required String passType,
//   }) async {
//     final String? token = await _secureStorage.read(key: 'authToken');
//     final String? companyId = await SessionManager.getCompanyId();
//     final String? userId = await SessionManager.getUserId();

//     print("DEBUG: Retrieved Token = $token");
//     print("DEBUG: Retrieved CompanyId = $companyId");
//     print("DEBUG: Retrieved UserId = $userId");

//     if (token == null) {
//       print("DEBUG: ERROR - Token is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: Token missing. Please log in again.'
//       };
//     }
//     if (companyId == null) {
//       print("DEBUG: ERROR - CompanyId is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: Company ID missing. Please log in again.'
//       };
//     }
//     if (userId == null) {
//       print("DEBUG: ERROR - UserId is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: User ID missing. Please log in again.'
//       };
//     }

//     final url = Uri.parse('${ApiConfig.baseUrl}/companies/$companyId/epasses');
//     print("DEBUG: API URL = $url");
//     print("DEBUG: Request Body = ${jsonEncode({
//       'fullName': fullName,
//       'email': email,
//       'department': department,
//       'designation': designation,
//       'passtype': passType,
//       'generatedBy': userId,
//     })}");

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           'fullName': fullName,
//           'email': email,
//           'department': department,
//           'designation': designation,
//           'passtype': passType,
//           'generatedBy': userId,
//         }),
//       );

//       print("DEBUG: Response Status Code = ${response.statusCode}");
//       print("DEBUG: Response Body = ${response.body}");

//       final responseBody = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return {
//           'success': true,
//           'message': responseBody['message'] ?? 'Pass generated successfully'
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'HTTP ${response.statusCode}: ${responseBody['message'] ?? 'Failed to generate pass'}'
//         };
//       }
//     } catch (e) {
//       print("DEBUG: Network Error = $e");
//       return {'success': false, 'message': 'Network error: $e'};
//     }
//   }

//   static Future<Map<String, dynamic>> bulkUploadPasses(
//       File file, String passType) async {
//     final String? token = await _secureStorage.read(key: 'authToken');
//     final String? companyId = await SessionManager.getCompanyId();
//     final String? userId = await SessionManager.getUserId();

//     print("DEBUG: Bulk Upload - Token = $token");
//     print("DEBUG: Bulk Upload - CompanyId = $companyId");
//     print("DEBUG: Bulk Upload - UserId = $userId");

//     if (token == null) {
//       print("DEBUG: ERROR - Bulk Upload: Token is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: Token missing. Please log in again.'
//       };
//     }
//     if (companyId == null) {
//       print("DEBUG: ERROR - Bulk Upload: CompanyId is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: Company ID missing. Please log in again.'
//       };
//     }
//     if (userId == null) {
//       print("DEBUG: ERROR - Bulk Upload: UserId is null");
//       return {
//         'success': false,
//         'message': 'Authentication error: User ID missing. Please log in again.'
//       };
//     }

//     final url = Uri.parse('${ApiConfig.baseUrl}/companies/$companyId/epasses/bulk');

//     try {
//       var request = http.MultipartRequest('POST', url);
//       request.headers['Authorization'] = 'Bearer $token';

//       request.fields['passtype'] = passType;
//       request.fields['generatedBy'] = userId;
//       request.files.add(await http.MultipartFile.fromPath('upload', file.path));

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//       final responseBody = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'message': responseBody['message'],
//           'data': responseBody,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': responseBody['message'] ?? 'Failed to upload file'
//         };
//       }
//     } catch (e) {
//       return {'success': false, 'message': 'An error occurred: $e'};
//     }
//   }
// }
