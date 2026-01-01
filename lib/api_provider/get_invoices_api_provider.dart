
import 'dart:math';

import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/models/get_invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class GetInvoiceProvider with ChangeNotifier {
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

        final allNotificationsModel =
            getInvoiceModelFromJson(response.body);
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

}
