import 'dart:math';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/all_notification_model.dart';

class GetAllNotificationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Error Fix: Notifcation ko NotificationItem se badal diya
  List<NotificationItem> _notifications = [];
  List<NotificationItem> get notifications => _notifications;

  Future<AllNotificationsModel> fetchAllNotifications() async {
    var token = await SessionHandlingViewModel().getToken();

    try {
      setLoadingState(true);
      var url = Uri.parse(ApiEndPoints.allNotifications);

      var response =
      await http.get(url, headers: {'x-auth-token': token ?? ''});

      if (response.statusCode == 200) {
        print(response.body);

        final allNotificationsModel =
        allNotificationsModelFromJson(response.body);

        // Error Fix: .notifcation ko .notifications kar diya
        _notifications = allNotificationsModel.notifications;
        notifyListeners();

        return allNotificationsModel;
      } else {
        if (kDebugMode)
          print(
              "Error: Fetching All Manager with status code ${response.statusCode}.");
      }
    } catch (e) {
      if (kDebugMode) print("Error: Fetching All Manager: ${e.toString()}");
    } finally {
      setLoadingState(false);
    }
    // Fixed: throw syntax (pehle variable 'e' define hona chahiye catch block mein)
    throw Exception("Failed to load notifications");
  }

  Future<void> updateNotificationStatus(String notificationId) async {
    try {
      var token = await SessionHandlingViewModel().getToken();

      var url =
      Uri.parse(ApiEndPoints.updateNotificationStatus(notificationId));
      var response =
      await http.put(url, headers: {'x-auth-token': token ?? ''});

      if (response.statusCode == 200) {
        // Update the local list of notifications
        final int index = _notifications
            .indexWhere((notification) => notification.id == notificationId);
        if (index != -1) {
          _notifications[index].isRead = true;

          // Notify listeners after updating isRead status
          notifyListeners();
        }
        // Handle success
        print('Notification status updated successfully.');
      } else {
        if (kDebugMode) {
          print(
              'Error: Updating notification status with status code ${response.statusCode}.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: Updating notification status: ${e.toString()}');
      }
    }
  }
}