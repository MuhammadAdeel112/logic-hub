// import 'dart:convert';
// import 'dart:math';
// import 'package:divine_employee_app/core/constants/api_end_points.dart';
// import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../core/utils/utlis.dart';
// import '../models/get_incident_model.dart';

// class GetIncidentProvider with ChangeNotifier {
//   Future<List<GetIncidentModel>> fetchIncidents() async {
//     var token = await SessionHandlingViewModel().getToken();
//     await Future.delayed(Duration(seconds: 1));

//     try {
//       var url = Uri.parse(ApiEndPoints.getIncidentReportEndPoints);

//       var response = await http.get(url, headers: {'x-auth-token': "$token"});

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = jsonDecode(response.body)['incidents'];
//         return jsonList.map((json) => GetIncidentModel.fromJson(json)).toList();
//       } else {
//         print(
//             "Error: Fetching incidents with status code ${response.statusCode}.");
//       }
//     } catch (e) {
//       print("Error: Fetching incidents: ${e.toString()}");
//       Utils.showToastMessage('${e.toString()}');
//     }
//     throw e;
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:divine_employee_app/core/constants/api_end_points.dart';
// import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
// import '../core/utils/utlis.dart';
// import '../models/get_incident_model.dart';

// class GetIncidentProvider with ChangeNotifier {
//   List<GetIncidentModel> _incidents = [];
//   bool _isLoading = false;
//   bool _hasError = false;
//   String _errorMessage = '';

//   List<GetIncidentModel> get incidents => _incidents;
//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchIncidents() async {
//     try {
//       _isLoading = true;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Your code here
//         notifyListeners();
//       });

//       var token = await SessionHandlingViewModel().getToken();
//       await Future.delayed(Duration(seconds: 1));

//       var url = Uri.parse(ApiEndPoints.getIncidentReportEndPoints);
//       var response = await http.get(url, headers: {'x-auth-token': "$token"});
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = jsonDecode(response.body)['incidents'];
//         _incidents =
//             jsonList.map((json) => GetIncidentModel.fromJson(json)).toList();
//       } else {
//         _hasError = true;
//         _errorMessage =
//             "Error: Fetching incidents with status code ${response.statusCode}.";
//         print(_errorMessage);
//       }
//     } catch (e) {
//       _hasError = true;
//       _errorMessage = "Error: Fetching incidents: ${e.toString()}";
//       print(_errorMessage);
//       Utils.showToastMessage('${e.toString()}');
//     } finally {
//       _isLoading = false;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Your code here
//         notifyListeners();
//       });
//     }
//   }
// }

import 'dart:convert';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import '../models/get_incident_model.dart';

class GetIncidentProvider with ChangeNotifier {
  List<GetIncidentModel> _allIncidents = [];
  List<GetIncidentModel> _filteredIncidents = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<GetIncidentModel> get incidents => _filteredIncidents;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> fetchIncidents() async {
    try {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      var token = await SessionHandlingViewModel().getToken();
      await Future.delayed(Duration(seconds: 1));

      var url = Uri.parse(ApiEndPoints.getIncidentReportEndPoints);
      var response = await http.get(url, headers: {'x-auth-token': "$token"});

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body)['incidents'];
        _allIncidents =
            jsonList.map((json) => GetIncidentModel.fromJson(json)).toList();
        _filteredIncidents =
            _allIncidents; // Initialize filtered incidents with all incidents
      } else {
        _hasError = true;
        _errorMessage =
            "Error: Fetching incidents with status code ${response.statusCode}.";
        print(_errorMessage);
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = "Error: Fetching incidents: ${e.toString()}";
      print(_errorMessage);
      Utils.showToastMessage('${e.toString()}');
    } finally {
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void searchIncidents(String query) {
    _filteredIncidents = _allIncidents
        .where((incident) =>
            incident.clientName.toLowerCase().contains(query.toLowerCase()) ||
            incident.staffName.toLowerCase().contains(query.toLowerCase()) ||
            incident.staffDesignation
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            incident.location.toLowerCase().contains(query.toLowerCase()) ||
            incident.description.toLowerCase().contains(query.toLowerCase()) ||
            incident.type.toLowerCase().contains(query.toLowerCase()) ||
            incident.action.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
