import 'dart:async';

import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  // Company ID - use configurable default (should be set at login)
  final String companyId = ApiConfig.defaultCompanyId;

  // Live Feed
  var liveFeedItems = <Map<String, String>>[].obs;
  var isLiveFeedLoading = true.obs;
  var liveFeedError = ''.obs;

  // Visitor Statistics
  var visitorStats = <String, int>{}.obs;
  var isStatsLoading = true.obs;
  var statsError = ''.obs;
  var selectedStatRange = 'This Week'.obs; // 'This Week', 'This Month', 'This Year', 'All'

  // Visitor Types (Pie Chart)
  var visitorTypes = <String, double>{}.obs;
  var isVisitorTypesLoading = true.obs;
  var visitorTypesError = ''.obs;
  var selectedVisitorTypeRange = 'This Week'.obs; // 'This Week', 'This Month', 'This Year', 'All'

  // Pending Visitors
  var pendingVisitors = <PendingVisitor>[].obs;
  var isPendingVisitorsLoading = true.obs;
  var pendingVisitorsError = ''.obs;

  // Stats Cards
  var todaysVisitors = 0.obs;
  var todaysCheckins = 0.obs;
  var todaysCheckouts = 0.obs;
  var isCardsLoading = true.obs;
  var cardsError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();

    // Refresh data periodically
    Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchLiveFeed();
      fetchPendingVisitors();
      fetchStatsCards();
    });
  }

  void fetchAllData() {
    fetchLiveFeed();
    fetchVisitorStats();
    fetchVisitorTypes();
    fetchPendingVisitors();
    fetchStatsCards();
  }

  // ==================== DATA FETCHING METHODS ====================

  void fetchLiveFeed() async {
    try {
      isLiveFeedLoading(true);
      liveFeedError('');
      final feedItems = await _apiService.getLiveFeed(companyId);
      liveFeedItems.assignAll(feedItems.map((e) => e.toDisplayMap()).toList());
    } catch (e) {
      liveFeedError('Failed to load live feed: $e');
    } finally {
      isLiveFeedLoading(false);
    }
  }

  void fetchVisitorStats() async {
    try {
      isStatsLoading(true);
      statsError('');
      final stats = await _apiService.getStatsSeries(
          companyId, selectedStatRange.value);
      final Map<String, int> formattedStats = {
        for (var stat in stats)
          stat['date']: (stat['count'] as num).toInt()
      };
      visitorStats.assignAll(formattedStats);
    } catch (e) {
      statsError('Failed to load visitor stats: $e');
    } finally {
      isStatsLoading(false);
    }
  }

  void fetchVisitorTypes() async {
    try {
      isVisitorTypesLoading(true);
      visitorTypesError('');
      final types = await _apiService.getVisitorTypes(
          companyId, selectedVisitorTypeRange.value);
      final Map<String, double> formattedTypes = {
        for (var type in types) type.type: type.count.toDouble()
      };
      visitorTypes.assignAll(formattedTypes);
    } catch (e) {
      visitorTypesError('Failed to load visitor types: $e');
    } finally {
      isVisitorTypesLoading(false);
    }
  }

  void fetchPendingVisitors() async {
    try {
      isPendingVisitorsLoading(true);
      pendingVisitorsError('');
      final visitors = await _apiService.getPendingVisitors(companyId);
      pendingVisitors.assignAll(visitors);
    } catch (e) {
      pendingVisitorsError('Failed to load pending visitors: $e');
      // ignore: avoid_print
      print('Error fetching pending visitors: $e');
    } finally {
      isPendingVisitorsLoading(false);
    }
  }

  void fetchStatsCards() async {
    try {
      isCardsLoading(true);
      cardsError('');
      final visitors = await _apiService.getTodaysVisitorsCount(companyId);
      final checkins = await _apiService.getTodaysCheckins(companyId);
      final checkouts = await _apiService.getTodaysCheckouts(companyId);
      todaysVisitors(visitors);
      todaysCheckins(checkins);
      todaysCheckouts(checkouts);
    } catch (e) {
      cardsError('Failed to load stats cards: $e');
    } finally {
      isCardsLoading(false);
    }
  }

  // ==================== USER ACTIONS ====================

  void changeStatRange(String newRange) {
    if (selectedStatRange.value != newRange) {
      selectedStatRange.value = newRange;
      fetchVisitorStats();
    }
  }

  void changeVisitorTypeRange(String newRange) {
    if (selectedVisitorTypeRange.value != newRange) {
      selectedVisitorTypeRange.value = newRange;
      fetchVisitorTypes();
    }
  }

  void approveVisitor(int index) {
    // TODO: Implement API call for approval
    // For now, just update the local state
    if (index < pendingVisitors.length) {
      // This is not ideal, we should be creating a new object
      // but for now this will work to update the UI.
      // final visitor = pendingVisitors[index];
      // pendingVisitors[index] = PendingVisitor(
      //   id: visitor.id,
      //   name: visitor.name,
      //   company: visitor.company,
      //   purpose: visitor.purpose,
      //   meetingWith: visitor.meetingWith,
      //   time: visitor.time,
      //   isApproved: true, // Update approval status
      //   photo: visitor.photo,
      //   createdAt: visitor.createdAt,
      // );
    }
  }

  void denyVisitor(int index) {
    // TODO: Implement API call for denial
    // For now, just remove from the local list
    if (index < pendingVisitors.length) {
      pendingVisitors.removeAt(index);
    }
  }

  // ==================== MOCK/DEMO DATA HELPERS ====================
  // These can be removed once the API is fully integrated and stable.

  void _generateMockLiveFeed() {
    liveFeedItems.assignAll([
      {
        'status': 'IN',
        'name': 'John Doe',
        'time': '10 min ago',
        'company': 'Google'
      },
      {
        'status': 'OUT',
        'name': 'Jane Smith',
        'time': '30 min ago',
        'company': 'Microsoft'
      },
      {
        'status': 'PENDING',
        'name': 'Peter Jones',
        'time': '1 hour ago',
        'company': 'Apple'
      },
    ]);
  }

  void _generateMockVisitorStats() {
    visitorStats.assignAll({
      'Mon': 120,
      'Tue': 150,
      'Wed': 170,
      'Thu': 160,
      'Fri': 190,
      'Sat': 130,
      'Sun': 100,
    });
  }

  void _generateMockVisitorTypes() {
    visitorTypes.assignAll({
      'Meeting': 45,
      'Delivery': 25,
      'Interview': 20,
      'Other': 10,
    });
  }

  void _generateMockPendingVisitors() {
    // This mock data is no longer valid with the new PendingVisitor model.
    // pendingVisitors.assignAll([
    //   PendingVisitor(
    //     id: 1,
    //     name: 'Alice Johnson',
    //     company: 'Innovate Corp',
    //     purpose: 'Project Meeting',
    //     createdAt: DateTime.now(),
    //     status: 'pending',
    //     meetingTime: DateTime.now(),
    //     host: Host(id: 1, name: 'Robert Brown', email: 'robert@example.com'),
    //   ),
    //   PendingVisitor(
    //     id: 2,
    //     name: 'Bob Williams',
    //     company: 'Solutions Inc',
    //     purpose: 'Sales Pitch',
    //     createdAt: DateTime.now(),
    //     status: 'pending',
    //     meetingTime: DateTime.now(),
    //     host: Host(id: 2, name: 'Susan White', email: 'susan@example.com'),
    //   ),
    // ]);
  }

  void _generateMockStatsCards() {
    todaysVisitors(25);
    todaysCheckins(15);
    todaysCheckouts(10);
  }

  /// Manual check-in for a visitor
  Future<bool> checkInVisitor(String visitorId) async {
    try {
      final success = await _apiService.manualCheckin(visitorId);
      if (success) {
        // Refresh live feed and stats after successful check-in
        fetchLiveFeed();
        fetchStatsCards();
      }
      return success;
    } catch (e) {
      print('Error checking in visitor: $e');
      return false;
    }
  }

  /// Manual check-out for a visitor
  Future<bool> checkOutVisitor(String visitorId) async {
    try {
      final success = await _apiService.manualCheckout(visitorId);
      if (success) {
        // Refresh live feed and stats after successful check-out
        fetchLiveFeed();
        fetchStatsCards();
      }
      return success;
    } catch (e) {
      print('Error checking out visitor: $e');
      return false;
    }
  }
}
