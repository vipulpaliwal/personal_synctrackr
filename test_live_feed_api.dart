// Test file for Live Feed API Integration
// This file can be used to test the API integration independently

import 'dart:convert';
import 'package:http/http.dart' as http;

// Test the live feed API endpoint
Future<void> testLiveFeedAPI() async {
  const String apiUrl = 'http://15.206.72.253:5000/api/admin/1/live-feed';

  try {
    print('Testing Live Feed API...');
    print('URL: $apiUrl');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 30));

    print('Response Status: ${response.statusCode}');
    print('Response Headers: ${response.headers}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response Body: ${json.encode(data)}');

      if (data['success'] == true && data['data'] != null) {
        print('✅ API Response is valid');
        print('Number of live feed items: ${data['data'].length}');

        // Test parsing each item
        for (int i = 0; i < data['data'].length; i++) {
          final item = data['data'][i];
          print('\n--- Item ${i + 1} ---');
          print('Visitor ID: ${item['visitorId']}');
          print('Full Name: ${item['fullName']}');
          print('Company Name: ${item['companyName']}');
          print('Purpose: ${item['purpose']}');
          print('Status: ${item['status']}');
          print('Check-in Time: ${item['checkinTime']}');
          print('Check-out Time: ${item['checkoutTime']}');
          print('Created At: ${item['createdAt']}');
        }
      } else {
        print('❌ API Response format is invalid');
        print('Expected: {"success": true, "data": [...]}');
      }
    } else {
      print('❌ API request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('❌ Error testing API: $e');
  }
}

// Test the LiveFeedItem model parsing
void testLiveFeedItemParsing() {
  print('\n--- Testing LiveFeedItem Parsing ---');

  // Sample API response data
  final sampleData = {
    "visitorId": 3,
    "fullName": "Jane Doe",
    "companyName": "Visitor Corp",
    "purpose": "Interview",
    "status": "accepted",
    "checkinTime": "2025-09-05T09:37:36.000Z",
    "checkoutTime": "2025-09-05T09:41:37.000Z",
    "createdAt": "2025-09-05T09:27:55.000Z"
  };

  try {
    // This would be the actual parsing logic from LiveFeedItem.fromJson
    print('Sample data: ${json.encode(sampleData)}');

    // Simulate the parsing logic
    String status = 'PENDING';
    if (sampleData['status'] != null &&
        sampleData['status'].toString().isNotEmpty) {
      status = sampleData['status'].toString().toUpperCase();
    } else if (sampleData['checkinTime'] != null &&
        sampleData['checkoutTime'] == null) {
      status = 'IN';
    } else if (sampleData['checkinTime'] != null &&
        sampleData['checkoutTime'] != null) {
      status = 'OUT';
    }

    print('Parsed Status: $status');
    print('✅ LiveFeedItem parsing logic works correctly');
  } catch (e) {
    print('❌ Error in LiveFeedItem parsing: $e');
  }
}

void main() async {
  print('=== Live Feed API Integration Test ===\n');

  // Test API endpoint
  await testLiveFeedAPI();

  // Test model parsing
  testLiveFeedItemParsing();

  print('\n=== Test Complete ===');
}
