import 'package:flutter/material.dart';

class AssignedJobTaskProvider extends ChangeNotifier {
  List<String> selectedTaskIds = [];
  
  int _totalLength = 5;
  int get totalLength => _totalLength;

  void setCurrentTab(int totalLength) {
    _totalLength = totalLength;
    notifyListeners();
  }

  void toggleTaskStatus(String taskId) {
    if (selectedTaskIds.contains(taskId)) {
      selectedTaskIds.remove(taskId);
    } else {
      selectedTaskIds.add(taskId);
    }

    notifyListeners();
  }
}

// class AvailableJobTaskProvider extends ChangeNotifier {
//   List<String> selectedTaskIds = [];

//   void toggleTaskStatus(String taskId) {
//     if (selectedTaskIds.contains(taskId)) {
//       selectedTaskIds.remove(taskId);
//     } else {
//       selectedTaskIds.add(taskId);
//     }

//     notifyListeners();
//   }
// }
