import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateOfBirth {
  DateTime? dateOfBirth;

  DateOfBirth(this.dateOfBirth);
}

class UserDateOfBirth extends ChangeNotifier {
  DateOfBirth _user = DateOfBirth(null);

  DateOfBirth get user => _user;

  void setDateOfBirth(DateTime date) {
    _user.dateOfBirth = date;
    notifyListeners();
  }

  void resetState() {
    _user = DateOfBirth(null);
    notifyListeners();
  }
}



  String formatDate(DateTime date) {
    // Format the date manually (without intl)
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      Provider.of<UserDateOfBirth>(context, listen: false).setDateOfBirth(picked);
    }
  }
