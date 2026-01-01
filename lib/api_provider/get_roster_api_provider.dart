import 'dart:math';

import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/models/get_invoice_model.dart';
import 'package:divine_employee_app/models/get_roster_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetRosterApiProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<GetInvoiceModel> fetchInvocies() async {
    var token = await SessionHandlingViewModel().getToken();

    try {
      setLoadingState(true);
      var url = Uri.parse(ApiEndPoints.getInvoice);

      var response =
          await http.get(url, headers: {'x-auth-token': token ?? ''});

      if (response.statusCode == 200) {
        print(response.body);

        final allNotificationsModel = getInvoiceModelFromJson(response.body);
        notifyListeners();

        return allNotificationsModel;
      } else {
        if (kDebugMode)
          print(
              "Error: Fetching  All Manager with status code ${response.statusCode}.");
      }
    } catch (e) {
      if (kDebugMode) print("Error: Fetching All Manager: ${e.toString()}");
    } finally {
      setLoadingState(false);
    }
    throw (e);
  }

  Future<GetRosterModel> fetchRosters(String date) async {
    var token = await SessionHandlingViewModel().getToken();

    try {
      var url = Uri.parse(ApiEndPoints.getRoster);
      var headers = {
        'x-auth-token': token ?? '',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var body = {
        'date': date,
      };

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final getRosterModel = getRosterModelFromJson(response.body);
        return getRosterModel;
      } else {
        if (kDebugMode) {
          print(
              "Error: Fetching rosters with status code ${response.statusCode}.");
          print("Error: Fetching rosters with bodyß ${response.body}.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: Fetching rosters: ${e.toString()}");
      }
    }
    throw Exception('Failed to fetch rosters');
  }
}
