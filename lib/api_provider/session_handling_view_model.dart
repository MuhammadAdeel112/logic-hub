import 'package:divine_employee_app/models/session_handling_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHandlingViewModel with ChangeNotifier {
  Future<bool> saveToken(String token) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('token', token);
      notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving token: $e');
      return false; // Token not saved
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    notifyListeners();
    return token;
  }

  Future<SessionHandlingModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return SessionHandlingModel(token: token.toString(), status: 200);
  }

  Future<bool> saveMyId(String my_id) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('my_id', my_id);
      notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving token: $e');
      return false; // Token not saved
    }
  }

  Future<String?> getMyId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('my_id');
    notifyListeners();
    return token;
  }

  Future removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    notifyListeners();
    return sp.clear();
  }
}
