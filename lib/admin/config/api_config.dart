class ApiConfig {
  // API Configuration
  static const String baseUrl =
      'http://15.206.72.253:5000'; // Updated to your actual backend URL

  // You can also use different URLs for different environments
  static const String devBaseUrl = 'http://15.206.72.253:5000/api';
  static const String prodBaseUrl = 'http://15.206.72.253:5000/api';

  // Get the appropriate base URL based on environment
  static String get apiBaseUrl {
    // You can add logic here to switch between dev/prod based on build mode
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? prodBaseUrl : devBaseUrl;
  }

  // Default company ID - This should be set from authentication/login
  static String defaultCompanyId = '1';

  // API endpoints
  static const String liveFeedEndpoint = '/admin/{companyId}/live-feed';
  static const String todaysVisitorsEndpoint =
      '/admin/{companyId}/visitors/today/count';
  static const String todaysCheckinsEndpoint =
      '/admin/{companyId}/checkins/today/count';
  static const String todaysCheckoutsEndpoint =
      '/admin/{companyId}/checkouts/today/count';
  static const String visitorStatsEndpoint =
      '/admin/{companyId}/stats/series/{range}';
  static const String pendingVisitorsEndpoint =
      '/admin/{companyId}/pending-visitors-enriched';
  static const String manualCheckinEndpoint = '/admin/visitors/check-in';
  static const String manualCheckoutEndpoint = '/admin/visitors/check-out';

  // Request timeout
  static const Duration requestTimeout = Duration(seconds: 30);

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
