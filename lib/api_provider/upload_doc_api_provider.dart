import 'dart:convert';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/view/documents/presentation/provider/expiry_date_provider.dart';
import 'package:divine_employee_app/view/documents/presentation/screens/upload_file_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:provider/provider.dart';

import '../core/constants/api_end_points.dart';

class UploadDocumentApiProvider with ChangeNotifier {
  bool isLoading = false;
  late Future<Map<String, dynamic>> _uplaodDocumentFuture;

  Future<Map<String, dynamic>> get uplaodDocumentFuture =>
      _uplaodDocumentFuture;
  Future<Map<String, dynamic>> UploadDocument({
    required String documentTitle,
    required String documentDetails,
    required DateTime documentExiprydate,
    required String documentPath,
    required context,
  }) async {
    try {
      print('\\\\\\\\\\\\\\\\\\\\');

      isLoading = true;
      notifyListeners(); // Notify listeners about the loading state change
      var token = await SessionHandlingViewModel().getToken();

      final headers = {
        'x-auth-token': token ?? '',
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiEndPoints.uploadDocEndPoints),
      );

      // Add fields to the request
      request.fields.addAll({
        'title': documentTitle,
        'details': documentDetails,
        // 'date': documentExiprydate.toString(),
        'date': documentExiprydate.toUtc().toIso8601String(),
      });

      // Add file to the request
      request.files.add(await http.MultipartFile.fromPath('doc', documentPath));

      request.headers.addAll(headers);

      final response = await request.send();

      if (kDebugMode) {
        print(
            'response code for document api provider : ${response.statusCode}');
        print(
            'response body for new api provider : ${await response.stream.bytesToString()}');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Provider.of<EmployeeProfileApiProvider>(context, listen: false)
        //     .fetchEmployeeProfileAndNotify(context);
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false)
            .fetchEmployeeProfile();

        if (kDebugMode) print('Request successful');
        Provider.of<ExpiryDateProvider>(context, listen: false)
            .setSelectedDate(DateTime.now());
        Provider.of<SelectedPDFPath>(context, listen: false).setPath('');
        _uplaodDocumentFuture = Future.value(
            {'success': true, 'message': 'Document submitted successfully'});
        return {
          'success': true,
          'message': 'Request successful',
        };
      } else {
        print('Request un-successful');

        final decodedBody = jsonDecode(await response.stream.bytesToString());
        _uplaodDocumentFuture =
            Future.value({'success': false, 'message': 'Unknown error'});
        print('Error: ${response.reasonPhrase}');
        return {
          'success': false,
          'message': decodedBody['msg'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      _uplaodDocumentFuture =
          Future.value({'success': false, 'message': 'Error: $e'});

      return {
        'success': false,
        'message': 'Error: $e',
      };
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners about the loading state change
    }
  }
}
