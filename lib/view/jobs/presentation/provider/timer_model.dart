// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TimerModel extends ChangeNotifier {
//   bool _isRunning = false;
//   int _seconds = 0;
//   late Timer _timer;
//   late DateTime _startTime;

//   bool get isRunning => _isRunning;
//   int get seconds => _seconds;

//   TimerModel() {
//     // Load the timer state when the TimerModel is created
//     loadTimerState();
//   }

//   void startTimer() {
//     _isRunning = true;
//     _startTime = DateTime.now(); // Set the start time
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _seconds++;
//       _saveTimerState(); // Save the timer state periodically
//       notifyListeners();
//     });
//   }

//   void pauseTimer() {
//     _isRunning = false;
//     _timer.cancel();
//     _saveTimerState(); // Save the timer state when paused
//     notifyListeners();
//   }

//   void resumeTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//         _seconds++;
//         _saveTimerState(); // Save the timer state periodically
//         notifyListeners();
//       });
//     }
//   }

//   void resetTimer() {
//     _isRunning = false;
//     _seconds = 0;
//     if (_timer.isActive) {
//       _timer.cancel();
//     }
//     _saveTimerState(); // Save the timer state when reset
//     notifyListeners();
//   }

//   int get hours => _seconds ~/ 3600;
//   int get minutes => (_seconds % 3600) ~/ 60;
//   int get remainingSeconds => _seconds % 60;

//   Future<Duration> getElapsedDuration() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String startTimeString = prefs.getString('start_time') ?? '';
//     if (startTimeString.isNotEmpty) {
//       DateTime startTime = DateTime.parse(startTimeString);
//       DateTime currentTime = DateTime.now();
//       return currentTime.difference(startTime);
//     }
//     return Duration.zero;
//   }

//   void _saveTimerState() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('timer_seconds', _seconds);
//     await prefs.setBool('timer_running', _isRunning);
//     await prefs.setString('start_time', _startTime.toIso8601String());
//   }

//   loadTimerState() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     // Check if the reset marker is set
//     bool isResetMarkerSet = prefs.getBool('reset_timer') ?? false;

//     if (isResetMarkerSet) {
//       // If reset marker is set, reset the timer
//       resetTimer();

//       // Remove the reset marker
//       await prefs.setBool('reset_timer', false);
//     } else {
//       // If reset marker is not set, load the timer state
//       _seconds = prefs.getInt('timer_seconds') ?? 0;
//       _isRunning = prefs.getBool('timer_running') ?? false;

//       if (_isRunning) {
//         // Calculate the elapsed duration and adjust the timer
//         Duration elapsedDuration = await getElapsedDuration();
//         _seconds += elapsedDuration.inSeconds;
//         resumeTimer(); // Resume the timer if it was running
//       }
//     }

//     notifyListeners();
//   }

//   void setResetMarker() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('reset_timer', true);
//   }
// }

/*
at some point if we need to use TimerModel then must do this
so first uncomment in main method 
then in provider declartion in multi provider
after that in clock out where we pause timer
then in generate report screen where we are resetting timer
then in job details tab bar with timer widget where we use this in conumser and in initstate
then in calculate hours widget where we are shwoing calculated hours

 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class WorkProvider extends ChangeNotifier {
//   DateTime? startTime;
//   DateTime? endTime;

//   Future<void> clockIn() async {
//     startTime = DateTime.now();
//     await saveClockInToSharedPreferences();
//     notifyListeners();
//   }

//   Future<void> clockOut() async {
//     endTime = DateTime.now();
//     await saveClockOutToSharedPreferences();
//     notifyListeners();
//   }

//   Duration getDuration() {
//     if (startTime != null && endTime != null) {
//       return endTime!.difference(startTime!);
//     } else {
//       return Duration.zero;
//     }
//   }

//   Future<void> saveClockInToSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('startTime', startTime?.toIso8601String() ?? "");
//   }

//   Future<void> saveClockOutToSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('endTime', endTime?.toIso8601String() ?? "");

//   }

//   Future<void> loadFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? startTimeString = prefs.getString('startTime');
//     final String? endTimeString = prefs.getString('endTime');

//     if (startTimeString != null) {
//       startTime = DateTime.parse(startTimeString);
//       print('::: ${startTime}');
//     }

//     if (endTimeString != null) {
//       endTime = DateTime.parse(endTimeString);
//       print('::: ${endTime}');
//     }

//     notifyListeners();
//   }
// }

class WorkProvider extends ChangeNotifier {
  DateTime? startTime;
  DateTime? endTime;
  late Timer _timer;

  WorkProvider() {
    // Set up a periodic timer to update UI every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }
  Future<void> clockIn() async {
    startTime = DateTime.now();
    await saveClockInToSharedPreferences();
    notifyListeners();
  }

  Future<void> clockOut() async {
    endTime = DateTime.now();
    await saveClockOutToSharedPreferences();
    notifyListeners();
  }

  Duration getCurrentDuration() {
    if (startTime != null) {
      return DateTime.now().difference(startTime!);
    } else {
      return Duration.zero;
    }
  }

  Duration getDuration() {
    if (startTime != null && endTime != null) {
      return endTime!.difference(startTime!);
    } else {
      return Duration.zero;
    }
  }

  Future<void> saveClockInToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('startTime', startTime?.toIso8601String() ?? "");
  }

  Future<void> saveClockOutToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _timer.cancel();
    prefs.setString('endTime', endTime?.toIso8601String() ?? "");
    // prefs.remove('endTime');
  }

  Future<void> submitTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('startTime');
    prefs.remove('endTime');
  }

  Future<void> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? startTimeString = prefs.getString('startTime');
    final String? endTimeString = prefs.getString('endTime');

    if (startTimeString != null) {
      startTime = DateTime.parse(startTimeString);
    }

    if (endTimeString != null) {
      endTime = DateTime.parse(endTimeString);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // Cancel the timer when the provider is disposed
    _timer.cancel();
    super.dispose();
  }
}
