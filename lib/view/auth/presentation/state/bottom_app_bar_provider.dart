import 'package:flutter/material.dart';

import '../../../jobs/presentation/screens/job_home_screen.dart';



class BottomNavigationBarProvider extends ChangeNotifier {
  int _currentTab = 5;
  int get currentTab => _currentTab;

  void setCurrentTab(int currentTab) {
    _currentTab = currentTab;
    notifyListeners();
  }

  Widget _currentScreen = JobHomeScreen();
  Widget get currentScreen => _currentScreen;
  void setCurrentScreen(Widget currentScreen) {
    _currentScreen = currentScreen;
    notifyListeners();
  }
}
