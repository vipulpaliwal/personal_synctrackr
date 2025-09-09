# Admin API Integration

This document explains the API integration implemented for the admin part of the SyncTrackr Flutter app.

## Overview

The admin part now uses real API data instead of dummy data for the live feed and other dashboard components. The integration includes:

- **Live Feed API**: Real-time visitor check-in/check-out data
- **Dashboard Statistics**: Today's visitor counts, check-ins, and check-outs
- **Pending Visitors**: List of visitors awaiting approval
- **Manual Check-in/Check-out**: API endpoints for manual visitor management

## File Structure

```
lib/admin/
├── config/
│   └── api_config.dart          # API configuration and endpoints
├── services/
│   └── api_services.dart        # API service methods and data models
├── controllers/
│   └── dashboard_controller.dart # Updated with API integration
└── widgets/
    └── live_feed.dart           # Updated with loading/error states
```

## Configuration

### API Base URL
Update the base URL in `lib/admin/config/api_config.dart`:

```dart
static const String baseUrl = 'http://localhost:3000'; // Change to your backend URL
```

### Company ID
Set the company ID in `api_config.dart` or through authentication:

```dart
static String defaultCompanyId = '1'; // Update with actual company ID
```

## API Endpoints Used

### Live Feed
- **GET** `/admin/{companyId}/live-feed`
- Returns recent visitor check-in/check-out activity

### Dashboard Statistics
- **GET** `/admin/{companyId}/visitors/today/count` - Today's visitor count
- **GET** `/admin/{companyId}/checkins/today/count` - Today's check-ins
- **GET** `/admin/{companyId}/checkouts/today/count` - Today's check-outs
- **GET** `/admin/{companyId}/stats/series/{range}` - Visitor statistics for charts

### Pending Visitors
- **GET** `/admin/{companyId}/pending-visitors-enriched` - List of pending visitors

### Manual Actions
- **POST** `/admin/visitors/check-in` - Manual visitor check-in
- **POST** `/admin/visitors/check-out` - Manual visitor check-out

## Features

### Loading States
- Shows loading indicators while fetching data
- Graceful error handling with retry options
- Empty state when no data is available

### Error Handling
- Network error handling with retry mechanism
- Fallback to empty states when API calls fail
- User-friendly error messages

### Data Refresh
- Automatic data loading on controller initialization
- Manual refresh functionality
- Real-time updates after check-in/check-out actions

## Usage

### Dashboard Controller
The `DashboardController` now automatically loads data from APIs:

```dart
final controller = Get.find<DashboardController>();

// Manual refresh
controller.refreshData();

// Check-in a visitor
await controller.checkInVisitor(visitorId);

// Check-out a visitor
await controller.checkOutVisitor(visitorId);
```

### Live Feed Widget
The `LiveFeed` widget now shows:
- Loading state while fetching data
- Error state with retry option
- Empty state when no recent activity
- Real visitor data from API

## Data Models

### LiveFeedItem
```dart
class LiveFeedItem {
  final String id;
  final String name;
  final String status; // 'IN', 'OUT', 'PENDING'
  final String time;   // Human-readable time
  final String? company;
  // ... other fields
}
```

### PendingVisitor
```dart
class PendingVisitor {
  final String id;
  final String name;
  final String? company;
  final String? purpose;
  final String? meetingWith;
  final bool isApproved;
  // ... other fields
}
```

## Backend Requirements

Ensure your backend (Synctrackr-Backend) is running and accessible at the configured base URL. The backend should implement the following endpoints as defined in `routes/admin.routes.js`.

## Environment Setup

1. **Install Dependencies**:
   ```bash
   cd synctrackr
   flutter pub get
   ```

2. **Update Configuration**:
   - Set the correct backend URL in `api_config.dart`
   - Set the correct company ID

3. **Run the App**:
   ```bash
   flutter run
   ```

## Testing

To test the API integration:

1. Ensure the backend is running
2. Check the console for any API errors
3. Verify that live feed shows real data
4. Test manual check-in/check-out functionality

## Troubleshooting

### Common Issues

1. **Network Errors**: Check if the backend is running and accessible
2. **CORS Issues**: Ensure backend allows requests from Flutter app
3. **Authentication**: Add authentication headers if required
4. **Data Format**: Verify API response format matches expected models

### Debug Mode

Enable debug logging by checking console output for API errors and responses.

## Future Enhancements

- Add authentication token handling
- Implement real-time updates using WebSockets
- Add offline support with local caching
- Implement pagination for large datasets
- Add more detailed error handling and user feedback
