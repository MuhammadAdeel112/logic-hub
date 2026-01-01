import 'package:flutter/material.dart';

class SelectIncidentTypeProvider extends ChangeNotifier {
  String _type = 'Select';

  String get type => _type;

  void setType(String type) {
    _type = type;
    notifyListeners();
  }
}

class ActionTakenByStaffProvider extends ChangeNotifier {
  String _type = 'Select';

  String get type => _type;

  void setAction(String type) {
    _type = type;
    notifyListeners();
  }
}
