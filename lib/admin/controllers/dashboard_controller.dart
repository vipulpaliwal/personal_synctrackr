import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  // Company ID - use configurable default (should be set at login)
  late final String companyId;

  // Live Feed
  var liveFeedItems = <LiveFeedItem>[].obs;
  var isLiveFeedLoading = true.obs;
  var liveFeedError = ''.obs;

  // Visitor Statistics
  var visitorStats = <String, int>{}.obs;
  var isStatsLoading = true.obs;
  var statsError = ''.obs;
  var selectedStatRange =
      'This Week'.obs; // 'This Week', 'This Month', 'This Year', 'All'

  // Visitor Types (Pie Chart)
  var visitorTypes = <String, double>{}.obs;
  var isVisitorTypesLoading = true.obs;
  var visitorTypesError = ''.obs;
  var selectedVisitorTypeRange =
      'This Week'.obs; // 'This Week', 'This Month', 'This Year', 'All'

  // Pending Visitors
  var pendingVisitors = <PendingVisitor>[].obs;
  var isPendingVisitorsLoading = true.obs;
  var pendingVisitorsError = ''.obs;

  // Stats Cards
  var todaysVisitors = 0.obs;
  var todaysCheckins = 0.obs;
  var todaysCheckouts = 0.obs;
  var monthlyVisitors = 0.obs;
  var isCardsLoading = true.obs;
  var cardsError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    companyId = await ApiConfig.getCompanyId();
    await _loadLiveFeedFromCache(); // Load cached data first
    await _loadPendingVisitorsFromCache(); // Load cached data first
    await _loadVisitorStatsFromCache();
    await _loadVisitorTypesFromCache();
    await _loadStatsCardsFromCache();
    fetchAllData();

    // Refresh data periodically
    Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchLiveFeed();
      fetchPendingVisitors();
      fetchStatsCards();
      fetchMonthlyVisitors();
    });
  }

  void fetchAllData() {
    fetchLiveFeed();
    fetchVisitorStats();
    fetchVisitorTypes();
    fetchPendingVisitors();
    fetchStatsCards();
    fetchMonthlyVisitors();
  }

  // ==================== DATA FETCHING METHODS ====================

  void fetchLiveFeed() async {
    try {
      isLiveFeedLoading(true);
      liveFeedError('');
      final feedItems = await _apiService.getLiveFeed(companyId);
      liveFeedItems.assignAll(feedItems);
      await _saveLiveFeedToCache(feedItems);
    } catch (e) {
      liveFeedError('Failed to load live feed: $e');
      // If API fails, try to load from cache if list is empty
      if (liveFeedItems.isEmpty) {
        await _loadLiveFeedFromCache();
      }
    } finally {
      isLiveFeedLoading(false);
    }
  }

  void fetchVisitorStats() async {
    try {
      isStatsLoading(true);
      statsError('');
      final stats =
          await _apiService.getStatsSeries(companyId, selectedStatRange.value);
      final Map<String, int> formattedStats = {
        for (var stat in stats) stat['date']: (stat['count'] as num).toInt()
      };
      visitorStats.assignAll(formattedStats);
      await _saveVisitorStatsToCache(formattedStats);
    } catch (e) {
      statsError('Failed to load visitor stats: $e');
      if (visitorStats.isEmpty) {
        await _loadVisitorStatsFromCache();
      }
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
      await _saveVisitorTypesToCache(formattedTypes);
    } catch (e) {
      visitorTypesError('Failed to load visitor types: $e');
      if (visitorTypes.isEmpty) {
        await _loadVisitorTypesFromCache();
      }
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
      await _savePendingVisitorsToCache(visitors);
    } catch (e) {
      pendingVisitorsError('Failed to load pending visitors: $e');
      if (pendingVisitors.isEmpty) {
        await _loadPendingVisitorsFromCache();
      }
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

      // Save to cache after successful fetch
      await _saveStatsCardsToCache({
        'todaysVisitors': visitors,
        'todaysCheckins': checkins,
        'todaysCheckouts': checkouts,
      });
    } catch (e) {
      cardsError('Failed to load stats cards: $e');
      // If API fails, try to load from cache
      await _loadStatsCardsFromCache();
    } finally {
      isCardsLoading(false);
    }
  }

  void fetchMonthlyVisitors() async {
    try {
      final stats = await _apiService.getStatsSeries(companyId, 'monthly');
      final int total = stats.fold<int>(0, (sum, item) {
        final dynamic value = item['count'];
        return sum +
            ((value is num)
                ? value.toInt()
                : int.tryParse(value?.toString() ?? '0') ?? 0);
      });
      monthlyVisitors(total);
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load monthly visitors: $e');
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
      LiveFeedItem(
        id: '1',
        name: 'John Doe',
        status: 'IN',
        time: '10 min ago',
        company: 'Google',
        createdAt: DateTime.now(),
      ),
      LiveFeedItem(
        id: '2',
        name: 'Jane Smith',
        status: 'OUT',
        time: '30 min ago',
        company: 'Microsoft',
        createdAt: DateTime.now(),
      ),
      LiveFeedItem(
        id: '3',
        name: 'Peter Jones',
        status: 'PENDING',
        time: '1 hour ago',
        company: 'Apple',
        createdAt: DateTime.now(),
      ),
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

  // ==================== CACHING METHODS ====================

  Future<void> _saveLiveFeedToCache(List<LiveFeedItem> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, String>> displayMaps = data.map((e) => e.toDisplayMap()).toList();
      final String encodedData = jsonEncode(displayMaps);
      await prefs.setString('liveFeedCache', encodedData);
    } catch (e) {
      print('Error saving live feed to cache: $e');
    }
  }

  Future<void> _loadLiveFeedFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('liveFeedCache');
      if (encodedData != null) {
        final List<dynamic> decodedData = jsonDecode(encodedData);
        liveFeedItems.assignAll(decodedData.map((item) {
          final map = Map<String, String>.from(item);
          return LiveFeedItem(
            id: '', // Not available in cache
            name: map['name'] ?? 'Unknown',
            status: map['status'] ?? 'PENDING',
            time: map['time'] ?? 'Just Now',
            company: map['company'],
            createdAt: DateTime.now(), // Not available in cache
          );
        }).toList());
      }
    } catch (e) {
      print('Error loading live feed from cache: $e');
    }
  }

  Future<void> _savePendingVisitorsToCache(List<PendingVisitor> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonData =
          data.map((e) => e.toJson()).toList();
      final String encodedData = jsonEncode(jsonData);
      await prefs.setString('pendingVisitorsCache', encodedData);
    } catch (e) {
      print('Error saving pending visitors to cache: $e');
    }
  }

  Future<void> _loadPendingVisitorsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('pendingVisitorsCache');
      if (encodedData != null) {
        final List<dynamic> decodedData = jsonDecode(encodedData);
        pendingVisitors.assignAll(
            decodedData.map((item) => PendingVisitor.fromJson(item)).toList());
      }
    } catch (e) {
      print('Error loading pending visitors from cache: $e');
    }
  }

  Future<void> _saveVisitorStatsToCache(Map<String, int> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(data);
      await prefs.setString('visitorStatsCache', encodedData);
    } catch (e) {
      print('Error saving visitor stats to cache: $e');
    }
  }

  Future<void> _loadVisitorStatsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('visitorStatsCache');
      if (encodedData != null) {
        final Map<String, dynamic> decodedData = jsonDecode(encodedData);
        visitorStats.assignAll(decodedData.map((key, value) => MapEntry(key, value as int)));
      }
    } catch (e) {
      print('Error loading visitor stats from cache: $e');
    }
  }

  Future<void> _saveVisitorTypesToCache(Map<String, double> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(data);
      await prefs.setString('visitorTypesCache', encodedData);
    } catch (e) {
      print('Error saving visitor types to cache: $e');
    }
  }

  Future<void> _loadVisitorTypesFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('visitorTypesCache');
      if (encodedData != null) {
        final Map<String, dynamic> decodedData = jsonDecode(encodedData);
        visitorTypes.assignAll(decodedData.map((key, value) => MapEntry(key, value as double)));
      }
    } catch (e) {
      print('Error loading visitor types from cache: $e');
    }
  }

  // ==================== STATS CARDS CACHING ====================

  Future<void> _saveStatsCardsToCache(Map<String, int> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(data);
      await prefs.setString('statsCardsCache', encodedData);
    } catch (e) {
      print('Error saving stats cards to cache: $e');
    }
  }

  Future<void> _loadStatsCardsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('statsCardsCache');
      if (encodedData != null) {
        final Map<String, dynamic> decodedData = jsonDecode(encodedData);
        todaysVisitors(decodedData['todaysVisitors'] ?? 0);
        todaysCheckins(decodedData['todaysCheckins'] ?? 0);
        todaysCheckouts(decodedData['todaysCheckouts'] ?? 0);
      }
    } catch (e) {
      print('Error loading stats cards from cache: $e');
    }
  }
}
