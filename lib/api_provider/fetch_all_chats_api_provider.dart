import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/data/app_exception.dart';
import 'package:divine_employee_app/core/data/response/api_response.dart';
import 'package:divine_employee_app/models/all_chats_model.dart';
import 'package:divine_employee_app/view/chats/presentation/screens/individual_chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/constants/api_end_points.dart';

class AllChatsProvider with ChangeNotifier {
  AllChatsModel? _allchats;

  AllChatsModel? get allChats => _allchats;

  ApiReponses<AllChatsModel> _apiResponse = ApiReponses.loading();

  ApiReponses<AllChatsModel> get apiResponse => _apiResponse;

  Future<void> fetchAllChats() async {
    try {
      // Set loading state
      _apiResponse = ApiReponses.loading();
      notifyListeners();

      var i = await SessionHandlingViewModel().getToken();
      var userId = await SessionHandlingViewModel().getMyId();
      await Future.delayed(Duration(seconds: 0));

      var url = Uri.parse(ApiEndPoints.allChats(userId));
      var response = await http.get(url,
          headers: {'x-auth-token': "$i"}).timeout(Duration(seconds: 10));
      // if (kDebugMode) print('::: Assigned Jobs ${response.body}');

      // Handle the response using the returnResponse function
      dynamic responseBody = returnResponse(response);
      // Convert the JSON response to AvailableJobsModel
      final AllChatsModel allchats = AllChatsModel.fromJson(responseBody);

      // Set completed state with data
      _apiResponse = ApiReponses.completed(allchats);
      _allchats = allchats;

      notifyListeners();
    } on SocketException catch (_) {
      // Handle socket exception (no internet connection)
      _apiResponse = ApiReponses.error('No internet connection');
      notifyListeners();
    } on TimeoutException catch (_) {
      // Handle timeout exception
      _apiResponse = ApiReponses.error('Request timeout');
      notifyListeners();
    } on AppException catch (e) {
      // Handle custom app exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    } on Exception catch (e) {
      // Handle other exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    }
  }

  void findAndCreateChat(String senderId, String receiverId, String jobId,
      String oponentName, BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(ApiEndPoints.findAndCreateChat));
    request.body = json.encode(
        {"senderId": senderId, "receiverId": receiverId, "jobId": jobId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // Parse the JSON response
      Map<String, dynamic> jsonResponse =
          json.decode(await response.stream.bytesToString());

      // Extract the _id field
      String chatId = jsonResponse['data']['_id'];

      Navigator.push(
          context,
          SlideTransitionPage(
              page: IndividualChatRoomScreen(
                  name: oponentName,
                  recevierId: receiverId,
                  chatId: chatId,
                  JobId: jobId)));
    } else {
      print(response.reasonPhrase);
    }
  }

  // Inside AvailableJobsProvider
  void clearchats() {
    _allchats = null;
    notifyListeners();
  }

}
