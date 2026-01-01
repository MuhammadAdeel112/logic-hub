import 'package:flutter/material.dart';

class Shift {
  DateTime startTime;
  DateTime endTime;

  Shift({required this.startTime, required this.endTime});
}

class Availability {
  DateTime date;
  List<Shift> shifts;
  bool isAvailableAllDay;

  Availability({
    required this.date,
    List<Shift>? shifts,
    this.isAvailableAllDay = false,
  }) : shifts = shifts ?? [];
}

class CreateAvailabilityProviderForLocal extends ChangeNotifier {
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(Duration(days: 6));
  List<Availability> _availabilities = [];
  bool _isAvailabilityCreated = false;

  bool get isAvailabilityCreated => _isAvailabilityCreated;
  DateTime get selectedStartDate => _selectedStartDate;
  DateTime get selectedEndDate => _selectedEndDate;
  List<Availability> get availabilities => _availabilities;
  // Method to reset the state to initial values
  void resetAvailability() {
    _selectedStartDate = DateTime.now();
    _selectedEndDate = DateTime.now().add(Duration(days: 6));
    _availabilities = [];
    _isAvailabilityCreated = false;
    notifyListeners();
  }

  set availabilityCreated(bool value) {
    _isAvailabilityCreated = value;
    notifyListeners();
  }

  set selectedStartDate(DateTime value) {
    _selectedStartDate = value;
    notifyListeners();
  }

  set selectedEndDate(DateTime value) {
    _selectedEndDate = value;
    notifyListeners();
  }

  set availabilities(List<Availability> value) {
    _availabilities = value;
    notifyListeners();
  }

  void toggleAllDay(int index) {
    _availabilities[index].isAvailableAllDay =
        !_availabilities[index].isAvailableAllDay;

    if (_availabilities[index].isAvailableAllDay) {
      _availabilities[index].shifts.clear();
    }

    notifyListeners();
  }

  List<Availability> generateInitialAvailabilities() {
    List<Availability> generatedAvailabilities = [];
    for (int i = 0;
        i <= _selectedEndDate.difference(_selectedStartDate).inDays;
        i++) {
      DateTime currentDate = _selectedStartDate.add(Duration(days: i));
      generatedAvailabilities.add(Availability(date: currentDate));
    }
    return generatedAvailabilities;
  }

  void addShift(int index, Shift shift) {
    _availabilities[index].shifts.add(shift);
    notifyListeners();
  }

  void removeShift(int index, int shiftIndex) {
    _availabilities[index].shifts.removeAt(shiftIndex);
    notifyListeners();
  }

  // Format DateTime to ISO8601 string
  String formatDateTime(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  // Parse ISO8601 string to DateTime
  DateTime parseDateTime(String iso8601String) {
    return DateTime.parse(iso8601String);
  }

  Map<String, dynamic> convertToApiFormat(String employeeId) {
    List<Map<String, dynamic>> apiDays = [];

    for (Availability availability in _availabilities) {
      Map<String, dynamic> apiDay = {
        'date': availability.date.toIso8601String(),
        'dayOfWeek': availability.date.weekday - 1,
        'fullDay': availability.isAvailableAllDay,
      };

      if (!availability.isAvailableAllDay) {
        List<Map<String, String>> shifts = [];

        for (Shift shift in availability.shifts) {
          Map<String, String> apiShift = {
            'startTime': shift.startTime.toIso8601String(), // Convert to string
            'endTime': shift.endTime.toIso8601String(), // Convert to string
          };

          shifts.add(apiShift);
        }

        apiDay['shifts'] = shifts;
      }

      apiDays.add(apiDay);
    }

    return {
      'employeeId': employeeId, // Replace with actual employee ID
      'startDate': _selectedStartDate.toIso8601String(),
      'endDate': _selectedEndDate.toIso8601String(),
      'days': apiDays,
    };
  }
}
