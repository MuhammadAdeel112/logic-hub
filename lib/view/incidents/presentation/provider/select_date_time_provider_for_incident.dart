// date_time_model.dart

import 'package:flutter/material.dart';

class selectDateTimeForIncidentProvider extends ChangeNotifier {
  DateTime _selectedDateTime = DateTime.now();

  DateTime get selectedDateTime => _selectedDateTime;

  void setSelectedDateTime(DateTime newDateTime) {
    _selectedDateTime = newDateTime;
    notifyListeners();
  }
}
