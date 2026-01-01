import 'dart:convert';
import 'package:divine_employee_app/view/availability/presentation/provider/avilability_notifier.dart';

import '../core/constants/api_end_points.dart';
import 'package:http/http.dart' as http;

class GetAvailabilityApi {
  final AvailabilityNotifier _notifier;

  GetAvailabilityApi(this._notifier);

  Future<List<DayAvailability>> fetchData(String employeeId) async {
    try {
      var response = await http.get(
        Uri.parse(ApiEndPoints.getAvailabilityEndpoint(employeeId)),
      );
      if (response.statusCode == 200) {
        print(':::GetAvailabilityApi ${response.body}');
        print(':::GetAvailabilityApi ${response.statusCode}');
        List<DayAvailability> data = parseResponse(response.body);
        _notifier.availabilityData = data;
        return data;
      } else {
        throw Exception('Failed to load availability data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  List<DayAvailability> parseResponse(String responseBody) {
    try {
      final Map<String, dynamic> data = jsonDecode(responseBody);

      final List<dynamic> days = data['availability']['days'];
      return days.map((day) {
        DateTime availabilityDate = DateTime.parse(day['date']);
        List<Shift> shifts = (day['shifts'] as List<dynamic>)
            .map((shift) => Shift(
                  startTime: DateTime.parse(shift['startTime']),
                  endTime: DateTime.parse(shift['endTime']),
                ))
            .toList();

        return DayAvailability(
          day: availabilityDate,
          isAvailableAllDay: day['fullDay'],
          shifts: shifts,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error parsing response: $e');
    }
  }
}

class DayAvailability {
  final DateTime day;
  final bool isAvailableAllDay;
  final List<Shift> shifts;

  DayAvailability({
    required this.day,
    required this.isAvailableAllDay,
    required this.shifts,
  });
}

class Shift {
  final DateTime startTime;
  final DateTime endTime;

  Shift({
    required this.startTime,
    required this.endTime,
  });
}
