import 'package:flutter/foundation.dart';

class ProfileImageProviderClass extends ChangeNotifier {
  String? _profileImagePath;

  String? get ProfileImagePath => _profileImagePath;

  void setProfileImagePath(String? path) {
    _profileImagePath = path;
    notifyListeners();
  }
}

class IncidentImageProviderClass extends ChangeNotifier {
  String? _incidentImagePath;

  String? get IncidentImagePath => _incidentImagePath;

  void setIncidentImagePath(String? path) {
    _incidentImagePath = path;
    notifyListeners();
  }
}

class ClaimExtraImageProviderClass extends ChangeNotifier {
  String? _claimExtraImagePath;

  String? get claimExtraImagePath => _claimExtraImagePath;

  void setClaimImagePath(String? path) {
    _claimExtraImagePath = path;
    notifyListeners();
  }
}
