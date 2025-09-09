class SearchResult {
  final String name;
  final String position;
  final String status;
  final String signedIn;
  final String signedOut;
  final String? duration;
  final String? host;

  SearchResult({
    required this.name,
    required this.position,
    required this.status,
    required this.signedIn,
    required this.signedOut,
    this.duration,
    this.host,
  });
}
