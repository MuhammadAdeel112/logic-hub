import 'package:divine_employee_app/api_provider/get_availability_api.dart';
import 'package:flutter/foundation.dart';

class AvailabilityNotifier extends ChangeNotifier {
  List<DayAvailability> _availabilityData = [];

  List<DayAvailability> get availabilityData => _availabilityData;

  set availabilityData(List<DayAvailability> data) {
    _availabilityData = data;
    notifyListeners();
  }

  resetAvailabilityData() {
    _availabilityData = [];
    notifyListeners();
  }
}
