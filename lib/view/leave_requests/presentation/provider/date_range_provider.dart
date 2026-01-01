import 'package:flutter/material.dart';

class DateRangeProvider with ChangeNotifier {
  DateTimeRange? _selectedRange;

  DateTimeRange? get selectedRange => _selectedRange;

  DateTime? get startDate => _selectedRange?.start;

  DateTime? get endDate => _selectedRange?.end;

  void setDateRange(DateTimeRange? range) {
    _selectedRange = range;
    notifyListeners();
  }

  void clearDateRange() {
    _selectedRange = null;
    notifyListeners();
  }
}
