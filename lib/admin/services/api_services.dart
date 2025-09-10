import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';

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
  // Headers for API requests
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Generic GET request method with timeout and retry
  Future<Map<String, dynamic>> _get(String endpoint) async {
    int retryCount = 0;

    while (retryCount < ApiConfig.maxRetries) {
      try {
        final response = await http
            .get(
              Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
              headers: _headers,
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
        final response = await http
            .post(
              Uri.parse('${ApiConfig.apiBaseUrl}$endpoint'),
              headers: _headers,
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
          throw Exception('Failed to post data: ${response.statusCode}');
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

  // ==================== EMPLOYEE LIST (STAFF) API ====================

  /// Fetch employees (staff) list for admin
  /// Backend route: GET /auth/staff (requires admin auth)
  /// Returns an array of staff with fields: userId, name, email, staffRole, dept, designation, status, mobileNumber
  Future<List<Map<String, dynamic>>> getEmployees() async {
    try {
      // Note: This endpoint currently mounted at /auth/staff in backend index.js
      final uri = Uri.parse('${ApiConfig.apiBaseUrl}/auth/staff');
      final response = await http
          .get(
            uri,
            headers: _headers,
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

  /// Fetch visitors for a specific company
  /// GET /api/admin/:companyId/visitors
  Future<List<Visitor>> getVisitors(String companyId) async {
    try {
      final response = await _get('/admin/$companyId/visitors');

      if (response['success'] == true && response['data'] != null) {
        List<dynamic> data = response['data'];
        final items = data
            .where((item) => item != null) // Filter out null items
            .map((item) => Visitor.fromJson(item as Map<String, dynamic>))
            .toList();
        return items;
      } else {
        throw Exception('Failed to fetch visitors data');
      }
    } catch (e) {
      throw Exception('Error fetching visitors: $e');
    }
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

      final response =
          await _get('/admin/$companyId/stats/series/$apiRange');
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
}
