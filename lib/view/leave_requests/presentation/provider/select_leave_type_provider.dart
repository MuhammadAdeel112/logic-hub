import 'package:flutter/material.dart';

class SelectLeaveTypeProvider extends ChangeNotifier {
  String _type= 'Select';

  String get type => _type;

  void setType(String type) {
    _type = type;
    notifyListeners();
  }
  void clearType(){
    _type = 'Select';
    notifyListeners();
  }
}
