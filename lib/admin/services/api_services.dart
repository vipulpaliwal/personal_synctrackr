import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/config/session_manager.dart';



// ==================== DATA MODELS ====================

class LiveFeedItem {
  final String id;
  final String name;
  final String status;
  final String time;
  final String? company;
  final DateTime? checkinTime;
  final DateTime? checkoutTime;
  final DateTime createdAt;

  LiveFeedItem({
    required this.id,
    required this.name,
    required this.status,
    required this.time,
    this.company,
    this.checkinTime,
    this.checkoutTime,
    required this.createdAt,
  });

  factory LiveFeedItem.fromJson(Map<String, dynamic> json) {
    // Determine status based on checkin/checkout times and API status
    String status = 'PENDING';
    String timeDisplay = 'Just Now';

    // First check the API status field
    if (json['status'] != null && json['status'].toString().isNotEmpty) {
      status = json['status'].toString().toUpperCase();
    } else {
      // Fallback to determining status based on checkin/checkout times
      if (json['checkinTime'] != null && json['checkoutTime'] == null) {
        status = 'IN';
      } else if (json['checkinTime'] != null && json['checkoutTime'] != null) {
        status = 'OUT';
      }
    }

    // Calculate time display based on checkin time or creation time
    DateTime? timeToUse;
    if (json['checkinTime'] != null) {
      timeToUse = DateTime.parse(json['checkinTime']);
    } else if (json['createdAt'] != null) {
      timeToUse = DateTime.parse(json['createdAt']);
    }

    if (timeToUse != null) {
      final now = DateTime.now();
      final difference = now.difference(timeToUse);

      if (difference.inMinutes < 1) {
        timeDisplay = 'Just Now';
      } else if (difference.inMinutes < 60) {
        timeDisplay = '${difference.inMinutes} Min ago';
      } else if (difference.inHours < 24) {
        timeDisplay =
            '${difference.inHours} Hour${difference.inHours > 1 ? 's' : ''} ago';
      } else {
        timeDisplay =
            '${difference.inDays} Day${difference.inDays > 1 ? 's' : ''} ago';
      }
    }

    return LiveFeedItem(
      id: json['visitorId']?.toString() ?? json['id']?.toString() ?? '',
      name: json['fullName'] ?? json['name'] ?? 'Unknown',
      status: status,
      time: timeDisplay,
      company: json['companyName'] ?? json['company'] ?? json['companyNme'],
      checkinTime: json['checkinTime'] != null
          ? DateTime.parse(json['checkinTime'])
          : null,
      checkoutTime: json['checkoutTime'] != null
          ? DateTime.parse(json['checkoutTime'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  // Convert to the format expected by the existing UI
  Map<String, String> toDisplayMap() {
    return {
      'status': status,
      'name': name,
      'time': time,
      'company': company ?? '',
    };
  }
}

class VisitorTypeStatistic {
  final String type;
  final int count;

  VisitorTypeStatistic({
    required this.type,
    required this.count,
  });

  factory VisitorTypeStatistic.fromJson(Map<String, dynamic> json) {
    return VisitorTypeStatistic(
      type: json['purpose'] ?? 'Unknown',
      count: int.tryParse(json['count']?.toString() ?? '0') ?? 0,
    );
  }
}

class VisitorStatistic {
  final String date;
  final int count;

  VisitorStatistic({
    required this.date,
    required this.count,
  });

  factory VisitorStatistic.fromJson(Map<String, dynamic> json) {
    return VisitorStatistic(
      date: json['date'] ?? '',
      count: int.tryParse(json['count']?.toString() ?? '0') ?? 0,
    );
  }
}

// ==================== API SERVICES ====================

class ApiService {
  static const _secureStorage = FlutterSecureStorage();

  // Headers for API requests
  static Future<Map<String, String>> get _headers async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authentication token if available
    final token = await _secureStorage.read(key: 'authToken');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Generic GET request method with timeout and retry
  Future<Map<String, dynamic>> _get(String endpoint) async {
    int retryCount = 0;

    while (retryCount < ApiConfig.maxRetries) {
      try {
        final headers = await _headers;
        final response = await http
            .get(
              Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
              headers: headers,
            )
            .timeout(ApiConfig.requestTimeout);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data is Map<String, dynamic>) {
            return data;
          }
          throw Exception('Invalid response format');
        } else {
          throw Exception('Failed to load data: ${response.statusCode}');
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= ApiConfig.maxRetries) {
          throw Exception(
              'Network error after ${ApiConfig.maxRetries} retries: $e');
        }

        // Wait before retrying
        await Future.delayed(ApiConfig.retryDelay);
      }
    }

    throw Exception('Max retries exceeded');
  }

  // Generic POST request method with timeout and retry
  Future<Map<String, dynamic>> _post(
      String endpoint, Map<String, dynamic> data) async {
    int retryCount = 0;

    while (retryCount < ApiConfig.maxRetries) {
      try {
        final headers = await _headers;
        final response = await http
            .post(
              Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
              headers: headers,
              body: json.encode(data),
            )
            .timeout(ApiConfig.requestTimeout);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = json.decode(response.body);
          if (data is Map<String, dynamic>) {
            return data;
          }
          throw Exception('Invalid response format');
        } else {
          // Do not retry for HTTP errors; surface server message
          try {
            final body = json.decode(response.body);
            final message = body is Map<String, dynamic>
                ? (body['message'] ??
                    body['error'] ??
                    body['errors']?.toString())
                : null;
            throw Exception(message ?? 'Failed: HTTP ${response.statusCode}');
          } catch (_) {
            throw Exception('Failed: HTTP ${response.statusCode}');
          }
        }
      } on TimeoutException catch (_) {
        retryCount++;
        if (retryCount >= ApiConfig.maxRetries) {
          throw Exception(
              'Network timeout after ${ApiConfig.maxRetries} retries');
        }
        await Future.delayed(ApiConfig.retryDelay);
      } on SocketException catch (_) {
        retryCount++;
        if (retryCount >= ApiConfig.maxRetries) {
          throw Exception(
              'Network error after ${ApiConfig.maxRetries} retries');
        }
        await Future.delayed(ApiConfig.retryDelay);
      } catch (e) {
        // Non-network error; do not retry
        rethrow;
      }
    }

    throw Exception('Max retries exceeded');
  }

  // Generic DELETE request method
  Future<Map<String, dynamic>> _delete(String endpoint) async {
    try {
      final headers = await _headers;
      final response = await http
          .delete(
            Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
            headers: headers,
          )
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          return data;
        }
        throw Exception('Invalid response format');
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // ==================== AUTHENTICATION API ====================

  /// Login a user
  /// POST /api/auth/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.apiBaseUrl}/auth/login'),
            headers: await _headers,
            body: json.encode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Success - return the response data
        return data;
      } else {
        // Return error response with status code for proper handling
        return {
          'success': false,
          'statusCode': response.statusCode,
          'message': data['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      // Network/timeout errors
      throw Exception('Network error: Unable to connect to server');
    }
  }


  // ==================== OTP (MOBILE VERIFICATION) ====================

  /// Send OTP to a mobile number
  /// POST /api/send-otp { phone }
  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    try {
      final response = await _post('/send-otp', {
        'phone': phone,
      });

      if (response['success'] == true && response['token'] != null) {
        return response;
      }
      throw Exception(response['message'] ?? 'Failed to send OTP');
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    }
  }

  /// Verify OTP with token
  /// POST /api/verify-otp { token, otp }
  Future<Map<String, dynamic>> verifyOtp({
    required String token,
    required String otp,
  }) async {
    try {
      // Match the OTP type to what's inside the JWT payload to satisfy strict equality on backend
      dynamic otpValue = otp.trim();
      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payloadJson =
              utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          final payload = json.decode(payloadJson);
          final payloadOtp =
              (payload is Map<String, dynamic>) ? payload['otp'] : null;
          if (payloadOtp is num) {
            // Backend stored otp as number; send number
            otpValue = int.parse(otp.trim());
          } else {
            // Backend stored otp as string; send string (preserve leading zeros)
            otpValue = otp.trim();
          }
        }
      } catch (_) {
        // Fallback to trimmed string if decoding fails
        otpValue = otp.trim();
      }

      final response = await _post('/verify-otp', {
        'token': token,
        'otp': otpValue,
      });

      if (response['success'] == true) {
        return response;
      }
      throw Exception(response['message'] ?? 'OTP verification failed');
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }

  // ==================== LIVE FEED API ====================

  /// Fetch live feed data for a specific company
  /// GET /api/admin/:companyId/live-feed
  Future<List<LiveFeedItem>> getLiveFeed(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/live-feed');

      if (response['success'] == true && response['data'] != null) {
        List<dynamic> data = response['data'];
        final items = data.map((item) => LiveFeedItem.fromJson(item)).toList();
        return items;
      } else {
        throw Exception('Failed to fetch live feed data');
      }
    } catch (e) {
      throw Exception('Error fetching live feed: $e');
    }
  }

  // ==================== DASHBOARD STATS API ====================

  /// Get today's visitors count
  /// GET /api/admin/:companyId/checkouts/today/count
  Future<int> getTodaysVisitorsCount(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/visitors/today/count');

      if (response['success'] == true) {
        return response['count'] ?? 0;
      } else {
        throw Exception('Failed to fetch today\'s visitors count');
      }
    } catch (e) {
      throw Exception('Error fetching today\'s visitors count: $e');
    }
  }

  // ====================  Others COMPANY SETTINGS / MODIFICATIONS ====================

  /// Patch company modifications (toggles/preferences)
  /// PATCH /api/admin/:companyId/settings/modifications
  Future<Map<String, dynamic>> updateCompanyModifications(
      String companyId, Map<String, dynamic> updates) async {
    try {
      final headers = await _headers;
      final response = await http
          .patch(
            Uri.parse(
                '${ApiConfig.apiBaseUrl}/admin/$companyId/settings/modifications'),
            headers: headers,
            body: json.encode(updates),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return data is Map<String, dynamic> ? data : {'success': true};
      } else if (response.statusCode == 403) {
        // Plan/trial restriction response
        throw Exception(data['message'] ??
            'This modification is not allowed on your current plan.');
      } else {
        throw Exception(data['message'] ?? 'Failed to update settings');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get today's check-ins count
  /// GET /api/admin/:companyId/checkins/today/count
  Future<int> getTodaysCheckins(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/checkins/today/count');

      if (response['success'] == true) {
        return response['count'] ?? 0;
      } else {
        throw Exception('Failed to fetch today\'s check-ins count');
      }
    } catch (e) {
      throw Exception('Error fetching today\'s check-ins count: $e');
    }
  }

  /// Get today's check-outs count
  /// GET /api/admin/:companyId/checkouts/today/count
  Future<int> getTodaysCheckouts(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/checkouts/today/count');

      if (response['success'] == true) {
        return response['count'] ?? 0;
      } else {
        throw Exception('Failed to fetch today\'s check-outs count');
      }
    } catch (e) {
      throw Exception('Error fetching today\'s check-outs count: $e');
    }
  }


  // ==================== E-PASS API FUNCTIONS ====================

  /// Create single e-pass
  /// POST /api/companies/:companyId/epasses
  Future<Map<String, dynamic>> createPass({
    required String fullName,
    required String email,
    String? department,
    String? designation,
    required String passType,
  }) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');
      final String? companyId = await SessionManager.getCompanyId();
      final String? userId = await SessionManager.getUserId();

      if (token == null || companyId == null || userId == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/epasses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'department': department,
          'designation': designation,
          'passtype': passType,
          'generatedBy': userId,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Pass generated successfully',
          'data': responseBody
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to generate pass'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  /// Bulk upload e-passes
  /// POST /api/companies/:companyId/epasses/bulk
  Future<Map<String, dynamic>> bulkUploadPasses(
      File file, String passType) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');
      final String? companyId = await SessionManager.getCompanyId();
      final String? userId = await SessionManager.getUserId();

      if (token == null || companyId == null || userId == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      // For web builds, multipart is not supported, so we'll use base64 approach
      final bytes = await file.readAsBytes();
      final base64File = base64Encode(bytes);
      final fileName = file.path.split('/').last;

      final response = await http.post(
        Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/epasses/bulk'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'file': base64File,
          'fileName': fileName,
          'passtype': passType,
          'generatedBy': userId,
        }),
      ).timeout(ApiConfig.requestTimeout);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Bulk upload successful',
          'data': responseBody,
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to upload file'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  /// List e-passes with pagination and search
  /// GET /api/companies/:companyId/epasses?search=&passtype=&page=&pageSize=
  Future<Map<String, dynamic>> listEpasses({
    required String companyId,
    String? search,
    String? passType,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final params = <String, String>{
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };
      if (search != null && search.isNotEmpty) params['search'] = search;
      if (passType != null && passType.isNotEmpty) params['passtype'] = passType;

      final query = params.entries
          .map((e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
          .join('&');

      return await _get('/companies/$companyId/epasses?$query');
    } catch (e) {
      throw Exception('Error fetching e-passes: $e');
    }
  }

  /// Export e-passes as CSV
  /// GET /api/companies/:companyId/epasses/export.csv?search=&passtype=
  Future<http.Response> exportEpassesCsv({
    required String companyId,
    String? search,
    String? passType,
  }) async {
    try {
      final params = <String, String>{};
      if (search != null && search.isNotEmpty) params['search'] = search;
      if (passType != null && passType.isNotEmpty) params['passtype'] = passType;

      final query = params.isEmpty
          ? ''
          : '?' +
              params.entries
                  .map((e) =>
                      '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
                  .join('&');

      final url = Uri.parse(
          '${ApiConfig.apiBaseUrl}/companies/$companyId/epasses/export.csv$query');

      return await http.get(url,
          headers: {'Accept': 'text/csv'}).timeout(ApiConfig.requestTimeout);
    } catch (e) {
      throw Exception('Error exporting e-passes: $e');
    }
  }

  /// Verify e-pass by QR token
  /// GET /api/companies/:companyId/epasses/verify/:token
  Future<Map<String, dynamic>> verifyPass(String companyId, String token) async {
    try {
      return await _get('/companies/$companyId/epasses/verify/$token');
    } catch (e) {
      throw Exception('Error verifying pass: $e');
    }
  }

  /// Get company settings including company, compliances and visitorForm
  /// GET /api/admin/:companyId/settings
  Future<Map<String, dynamic>> getCompanySettings(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/settings');
      return response;
    } catch (e) {
      throw Exception('Error fetching company settings: $e');
    }
  }

  /// Get visitor types statistics for pie chart
  /// GET /api/admin/:companyId/stats/purpose
  Future<List<VisitorTypeStatistic>> getVisitorTypes(
      String companyId, String range) async {
    try {
      final now = DateTime.now();
      DateTime from;
      switch (range) {
        case 'This Week':
          from = now.subtract(const Duration(days: 7));
          break;
        case 'This Month':
          from = DateTime(now.year, now.month, 1);
          break;
        case 'This Year':
          from = DateTime(now.year, 1, 1);
          break;
        case 'All':
          from = DateTime(2000);
          break;
        default:
          from = now.subtract(const Duration(days: 7));
      }
      final to = now;

      final response = await _get(
          '/admin/$companyId/stats/purpose?from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}');

      if (response['success'] == true && response['data'] != null) {
        List<dynamic> data = response['data'];
        return data.map((item) => VisitorTypeStatistic.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch visitor types');
      }
    } catch (e) {
      throw Exception('Error fetching visitor types: $e');
    }
  }

  /// Get pending visitors
  /// GET /api/admin/:companyId/pending-visitors-enriched
  Future<List<PendingVisitor>> getPendingVisitors(String companyId,
      {int limit = 20, int offset = 0}) async {
    try {
      final response = await _get(
          '/admin/$companyId/pending-visitors-enriched?limit=$limit&offset=$offset');

      if (response['success'] == true && response['data'] != null) {
        List<dynamic> data = response['data'];
        return data.map((item) => PendingVisitor.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch pending visitors');
      }
    } catch (e) {
      throw Exception('Error fetching pending visitors: $e');
    }
  }

  // ==================== MANUAL CHECK-IN/OUT API ====================

  /// Manual check-in for a visitor
  /// POST /api/admin/visitors/check-in
  Future<bool> manualCheckin(String visitorId) async {
    try {
      final response = await _post('/admin/visitors/check-in', {
        'visitorId': visitorId,
      });

      return response['success'] == true;
    } catch (e) {
      throw Exception('Error during manual check-in: $e');
    }
  }

  /// Manual check-out for a visitor
  /// POST /api/admin/visitors/check-out
  Future<bool> manualCheckout(String visitorId) async {
    try {
      final response = await _post('/admin/visitors/check-out', {
        'visitorId': visitorId,
      });

      return response['success'] == true;
    } catch (e) {
      throw Exception('Error during manual check-out: $e');
    }
  }

  /// Manual check-in for a visitor (enriched endpoint)
  /// POST /api/admin/visitors/check-in
  Future<bool> manualCheckinEnriched(String visitorId) async {
    try {
      final response = await _post('/admin/visitors/check-in', {
        'visitorId': visitorId,
      });
      return response['success'] == true;
    } catch (e) {
      throw Exception('Error during manual check-in: $e');
    }
  }

  /// Fetch enriched visitor (to check status before  manualcheckout)
  Future<Map<String, dynamic>?> getEnrichedVisitorIfAny(
      String visitorId) async {
    try {
      final resp = await _get('/admin/visitors/$visitorId/enriched');
      return resp;
    } catch (e) {
      return null;
    }
  }

  // ==================== EMPLOYEE LIST (STAFF) API ====================

  /// Fetch employees (staff) list for admin
  /// Backend route: GET /auth/staff (requires admin auth)
  /// Returns an array of staff with fields: userId, name, email, staffRole, dept, designation, status, mobileNumber
  Future<List<Map<String, dynamic>>> getEmployees() async {
    try {
      // Note: This endpoint currently mounted at /auth/staff in backend index.js
      final uri = Uri.parse('${ApiConfig.apiBaseUrl}/auth/staff');
      final headers = await _headers;
      final response = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }

      throw Exception('Failed to fetch employees: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }

  /// Fetch heads for a specific company
  /// GET /api/admin/:companyId/heads
  Future<Map<String, dynamic>> getHeads(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/heads');

      if (response['success'] == true && response['data'] != null) {
        return {
          'totalHeads': response['totalHeads'],
          'totalDepartments': response['totalDepartments'],
          'data': response['data'],
        };
      } else {
        throw Exception('Failed to fetch heads data');
      }
    } catch (e) {
      throw Exception('Error fetching heads: $e');
    }
  }

  /// Export visitors as CSV for a specific company
  /// GET /api/admin/:companyId/visitors/export.csv
  Future<http.Response> exportVisitorsCsv({
    required String companyId,
    String? status,
    String? search,
    String? purpose,
    String? from,
    String? to,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String>[];
      if (status != null && status.isNotEmpty && status != 'All') {
        queryParams.add('status=$status');
      }
      if (search != null && search.isNotEmpty) {
        queryParams.add('search=$search');
      }
      if (purpose != null && purpose.isNotEmpty) {
        queryParams.add('purpose=$purpose');
      }
      if (from != null && from.isNotEmpty) {
        queryParams.add('from=$from');
      }
      if (to != null && to.isNotEmpty) {
        queryParams.add('to=$to');
      }

      final endpoint = queryParams.isNotEmpty
          ? '/admin/$companyId/visitors/export.csv?${queryParams.join('&')}'
          : '/admin/$companyId/visitors/export.csv';

      final headers = await _headers;
      final response = await http
          .get(
            Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
            headers: headers,
          )
          .timeout(ApiConfig.requestTimeout);

      return response;
    } catch (e) {
      throw Exception('Error exporting visitors CSV: $e');
    }
  }

  /// Fetch visitors for a specific company
  /// GET /api/admin/:companyId/visitors
  Stream<List<Visitor>> getVisitors(String companyId, {String? status}) {
    late StreamController<List<Visitor>> controller;
    Timer? timer;

    Future<void> fetch() async {
      try {
        // Build query parameters
        final queryParams = <String>[];
        if (status != null && status.isNotEmpty) {
          queryParams.add('status=$status');
        }

        final endpoint = queryParams.isNotEmpty
            ? '/admin/$companyId/visitors?${queryParams.join('&')}'
            : '/admin/$companyId/visitors';

        final response = await _get(endpoint);
        if (response['success'] == true && response['data'] != null) {
          List<dynamic> data = response['data'];
          final items = data
              .where((item) => item != null)
              .map((item) => Visitor.fromJson(item as Map<String, dynamic>))
              .toList();
          if (!controller.isClosed) {
            controller.add(items);
          }
        } else {
          if (!controller.isClosed) {
            controller.addError('Failed to fetch visitors data');
          }
        }
      } catch (e) {
        if (!controller.isClosed) {
          controller.addError('Error fetching visitors: $e');
        }
      }
    }

    controller = StreamController<List<Visitor>>(
      onListen: () {
        fetch();
        timer = Timer.periodic(const Duration(seconds: 5), (_) => fetch());
      },
      onCancel: () {
        timer?.cancel();
      },
    );

    return controller.stream;
  }

  /// Fetch enriched visitor details
  /// GET /api/admin/visitors/:visitorId/enriched
  Future<Map<String, dynamic>> fetchEnrichedVisitor(int visitorId) async {
    try {
      final response = await _get('/admin/visitors/$visitorId/enriched');
      return response;
    } catch (e) {
      throw Exception('Error fetching enriched visitor: $e');
    }
  }

  Future<Map<String, dynamic>> createVisitorHead(
      Map<String, dynamic> data) async {
    try {
      final response = await _post('/auth/staff', data);
      return response;
    } catch (e) {
      throw Exception('Error creating visitor head: $e');
    }
  }

  Future<Map<String, dynamic>> addStaff(
      Map<String, dynamic> data, String token) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.apiBaseUrl}/auth/staff'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode(data),
          )
          .timeout(ApiConfig.requestTimeout);

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Failed to add staff');
      }
    } catch (e) {
      throw Exception('Error adding staff: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getStatsSeries(
      String companyId, String range) async {
    try {
      String apiRange;
      switch (range) {
        case 'monthly':
          apiRange = 'month';
          break;
        case 'weekly':
          apiRange = 'week';
          break;
        case 'yearly':
          apiRange = 'month'; // Default to month for yearly
          break;
        case 'daily':
          apiRange = 'day';
          break;
        default:
          apiRange = 'week'; // Default to week
      }

      final response = await _get('/admin/$companyId/stats/series/$apiRange');
      if (response['success'] == true && response['data'] != null) {
        return List<Map<String, dynamic>>.from(response['data']);
      } else {
        throw Exception(
            'Failed to fetch stats series: ${response['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Error fetching stats series: $e');
    }
  }

  Future<http.Response> getHeadDetails(String headId,
      {String? companyId}) async {
    final companyIdToUse = companyId ?? await ApiConfig.getCompanyId();
    final headers = await _headers;
    final response = await http.get(
      Uri.parse('${ApiConfig.apiBaseUrl}/admin/$companyIdToUse/heads/$headId'),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> updateHead(String headId, Map<String, dynamic> data,
      {String? companyId}) async {
    final companyIdToUse = companyId ?? await ApiConfig.getCompanyId();
    final headers = await _headers;
    final response = await http.patch(
      Uri.parse('${ApiConfig.apiBaseUrl}/admin/$companyIdToUse/heads/$headId'),
      headers: headers,
      body: json.encode(data),
    );
    return response;
  }

  // ==================== E-PASS BULK UPLOAD ====================

  /// Upload bulk e-passes file (CSV/XLS/XLSX)
  /// POST /api/companies/:companyId/epasses/bulk
  /// file field name: "upload"
  Future<Map<String, dynamic>> uploadBulkEpasses(
      {required String companyId, required String filePath}) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      // For web builds, multipart is not supported, so we'll use base64 approach
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final base64File = base64Encode(bytes);
      final fileName = file.path.split('/').last;

      final response = await http.post(
        Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/epasses/bulk'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'file': base64File,
          'fileName': fileName,
        }),
      ).timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data is Map<String, dynamic> ? data : {'success': true};
      }
      throw Exception(data['message'] ?? 'Bulk upload failed');
    } catch (e) {
      throw Exception('Error uploading bulk e-passes: $e');
    }
  }

  // ==================== COMPLIANCES ====================

  /// PUT /api/admin/:companyId/compliances { compliances: ["Mask", ...] }
  Future<Map<String, dynamic>> putCompliances(
      {required String companyId, required List<String> compliances}) async {
    try {
      final headers = await _headers;
      final resp = await http
          .put(
            Uri.parse('${ApiConfig.apiBaseUrl}/admin/$companyId/compliances'),
            headers: headers,
            body: json.encode({
              'compliances': compliances,
            }),
          )
          .timeout(ApiConfig.requestTimeout);
      final data = json.decode(resp.body);
      if (resp.statusCode == 200) return data;
      throw Exception(data['message'] ?? 'Failed to update compliances');
    } catch (e) {
      throw Exception('Error updating compliances: $e');
    }
  }

  // ==================== VISITOR FORM (single per company) ====================

  /// GET /api/admin/:companyId/visitor-forms
  Future<Map<String, dynamic>> getVisitorForm(String companyId) async {
    return await _get('/admin/$companyId/visitor-forms');
  }

  /// PUT /api/admin/:companyId/visitor-form { fields: {...}, remove: [] }
  Future<Map<String, dynamic>> saveVisitorForm(
      {required String companyId,
      Map<String, dynamic> fields = const {},
      List<String> remove = const []}) async {
    try {
      final headers = await _headers;
      final resp = await http
          .put(
            Uri.parse('${ApiConfig.apiBaseUrl}/admin/$companyId/visitor-form'),
            headers: headers,
            body: json.encode({'fields': fields, 'remove': remove}),
          )
          .timeout(ApiConfig.requestTimeout);
      final data = json.decode(resp.body);
      if (resp.statusCode == 200) return data;
      throw Exception(data['message'] ?? 'Failed to save visitor form');
    } catch (e) {
      throw Exception('Error saving visitor form: $e');
    }
  }

  /// DELETE /api/admin/:companyId/compliances { remove: ["Mask"] }
  Future<Map<String, dynamic>> deleteCompliances(
      {required String companyId, required List<String> remove}) async {
    try {
      final headers = await _headers;
      final req = http.Request('DELETE',
          Uri.parse('${ApiConfig.apiBaseUrl}/admin/$companyId/compliances'));
      req.headers.addAll(headers);
      req.body = json.encode({'remove': remove});
      final streamed = await req.send().timeout(ApiConfig.requestTimeout);
      final resp = await http.Response.fromStream(streamed);
      final data = json.decode(resp.body);
      if (resp.statusCode == 200) return data;
      throw Exception(data['message'] ?? 'Failed to remove compliances');
    } catch (e) {
      throw Exception('Error removing compliances: $e');
    }
  }

  /// Get returning visitors
  /// GET /api/admin/:companyId/visitors/returning
  Future<List<Map<String, dynamic>>> getReturningVisitors(
      String companyId) async {
    try {
      final response = await _get('/admin/$companyId/visitors/returning');

      if (response['success'] == true && response['data'] != null) {
        return List<Map<String, dynamic>>.from(response['data']);
      } else {
        throw Exception(
            'Failed to fetch returning visitors: ${response['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Error fetching returning visitors: $e');
    }
  }

  // ==================== COMPANY MANAGEMENT API ====================

  /// Create a new company with admin user
  /// POST /api/companies
  Future<Map<String, dynamic>> createCompany({
    required String companyName,
    required String email,
    required String adminName,
    required String adminEmail,
    required String adminPassword,
    String? adminMobile,
    String? phone,
    String plan = 'free',
  }) async {
    try {
      final headers = await _headers;
      final response = await http
          .post(
            Uri.parse('${ApiConfig.apiBaseUrl}/companies'),
            headers: headers,
            body: json.encode({
              'companyName': companyName,
              'email': email,
              'adminName': adminName,
              'adminEmail': adminEmail,
              'adminPassword': adminPassword,
              'adminMobile': adminMobile,
              'phone': phone,
              'plan': plan,
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Company created successfully',
          'data': data
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? data['error'] ?? 'Failed to create company',
          'statusCode': response.statusCode
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Get company details by ID
  /// GET /api/companies/:id
  Future<Map<String, dynamic>> getCompany(String companyId) async {
    try {
      final response = await _get('/companies/$companyId');

      // The API returns the company object directly.
      // We wrap it in the format the UI expects.
      return {
        'success': true,
        'data': response
      };
    } catch (e) {
      // The _get method throws an exception on failure, which is caught here.
      // We re-throw it to be handled by the UI.
      throw Exception('Error fetching company: $e');
    }
  }

  /// Update company details
  /// PATCH /api/companies/:id
  Future<Map<String, dynamic>> updateCompany({
    required String companyId,
    String? companyName,
    String? email,
    String? phone,
    String? companyLogo,
  }) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      final Map<String, dynamic> updateData = {};
      if (companyName != null) updateData['companyName'] = companyName;
      if (email != null) updateData['email'] = email;
      if (phone != null) updateData['phone'] = phone;
      if (companyLogo != null) updateData['companyLogo'] = companyLogo;

      final response = await http
          .patch(
            Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode(updateData),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Company updated successfully',
          'data': data
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? data['error'] ?? 'Failed to update company',
          'statusCode': response.statusCode
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Change company plan
  /// POST /api/companies/:companyId/plan
  Future<Map<String, dynamic>> changeCompanyPlan({
    required String companyId,
    required String newPlan,
  }) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      final response = await http
          .post(
            Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/plan'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              'plan': newPlan,
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Plan changed successfully',
          'data': data
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? data['error'] ?? 'Failed to change plan',
          'statusCode': response.statusCode
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Get company features based on current plan
  /// GET /api/companies/:id/features
  Future<Map<String, dynamic>> getCompanyFeatures(String companyId) async {
    try {
      final response = await _get('/companies/$companyId/features');

      if (response['success'] == true) {
        return {
          'success': true,
          'features': response['features'] ?? {},
          'plan': response['plan'] ?? 'free',
          'limits': response['limits'] ?? {}
        };
      } else {
        throw Exception('Failed to fetch company features');
      }
    } catch (e) {
      throw Exception('Error fetching company features: $e');
    }
  }

  /// Upload company logo
  /// POST /api/companies/:id/upload-logo
  Future<Map<String, dynamic>> uploadCompanyLogo({
    required String companyId,
    required String filePath,
  }) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      // For web builds, multipart is not supported, so we'll use a different approach
      // We'll send the file as base64 encoded data
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final base64File = base64Encode(bytes);
      final fileName = file.path.split('/').last;

      final response = await http.post(
        Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/upload-logo'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'file': base64File,
          'fileName': fileName,
        }),
      ).timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Logo uploaded successfully',
          'logoUrl': data['logoUrl']
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? data['error'] ?? 'Failed to upload logo',
          'statusCode': response.statusCode
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Validate plan change (check if allowed)
  /// POST /api/companies/:id/validate-plan
  Future<Map<String, dynamic>> validatePlanChange({
    required String companyId,
    required String newPlan,
  }) async {
    try {
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication error. Please log in again.'
        };
      }

      final response = await http
          .post(
            Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/validate-plan'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              'newPlan': newPlan,
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'valid': data['valid'] ?? false,
          'message': data['message'] ?? 'Plan change validated'
        };
      } else {
        return {
          'success': false,
          'valid': false,
          'message': data['message'] ?? data['error'] ?? 'Plan validation failed',
          'statusCode': response.statusCode
        };
      }
    } catch (e) {
      return {
        'success': false,
        'valid': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Get company plan history
  /// GET /api/companies/:id/plan-history
  Future<Map<String, dynamic>> getCompanyPlanHistory(String companyId) async {
    try {
      final response = await _get('/companies/$companyId/plan-history');

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'history': response['data']
        };
      } else {
        throw Exception('Failed to fetch plan history');
      }
    } catch (e) {
      throw Exception('Error fetching plan history: $e');
    }
  }
}
