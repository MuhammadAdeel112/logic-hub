import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';

Future<Map<String, dynamic>?> getCurrentLocation(BuildContext context) async {
  try {
    final location = loc.Location();

    // Check if service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Utils.showFlushbar('Please enable location services', context);
        Future.delayed(Duration(seconds: 1)).then((onValue){
          return null;
        });
      }
    }

    // Check for permissions
    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        Utils.showFlushbar('Please grant location permission', context);
        return null;
      }
    }

    // Get current location
    loc.LocationData locationData = await location.getLocation();
    double latitude = locationData.latitude ?? 0.0;
    double longitude = locationData.longitude ?? 0.0;

    if (kDebugMode) {
      print("Latitude: $latitude, Longitude: $longitude");
    }

    // Reverse geocoding
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(latitude, longitude);
    String formattedAddress = "Unknown Location";

    if (placemarks.isNotEmpty) {
      geo.Placemark place = placemarks.first;
      formattedAddress =
      "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }

    if (kDebugMode) print("Current Address: $formattedAddress");

    return {
      "formattedAddress": formattedAddress,
      "lat": latitude,
      "long": longitude,
    };
  } catch (e) {
    if (kDebugMode) print("Error getting location: $e");
    return null;
  }
}









// import 'package:divine_employee_app/core/utils/utlis.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// Future<Map<String, dynamic>?> getCurrentLocation(BuildContext context) async {
//   try {
//     // // Check if location services are enabled
//     // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     // if (!serviceEnabled) {
//     //   if(kDebugMode) print("Location services are disabled.");
//     //   Utils.showFlushbar(
//     //       'Please Enable Location', context);
//     //   Future.delayed(Duration(seconds: 1)).then((onValue){
//     //     return null;
//     //   });
//     //
//     // }
//     //
//     // // Request permission
//     // LocationPermission permission = await Geolocator.checkPermission();
//     // if (permission == LocationPermission.denied) {
//     //   permission = await Geolocator.requestPermission();
//     //   if (permission == LocationPermission.denied) {
//     //     if(kDebugMode) print("Location permissions are denied.");
//     //     Utils.showFlushbar(
//     //         'Please Enable Location', context);
//     //     Future.delayed(Duration(seconds: 2)).then((onValue){
//     //       return null;
//     //     });
//     //   }
//     // }
//     //
//     // if (permission == LocationPermission.deniedForever) {
//     //   if(kDebugMode) print("Location permissions are permanently denied.");
//     //   Utils.showFlushbar(
//     //       'Please Enable Location Access from Device Settings', context);
//     //   Future.delayed(Duration(seconds: 2)).then((onValue) async {
//     //     await openAppSettings();
//     //   });
//     // }
//     //
//     // // Get current position
//     // Position position = await Geolocator.getCurrentPosition(
//     //   desiredAccuracy: LocationAccuracy.high,
//     // );
//     //
//     // double latitude = position.latitude;
//     // double longitude = position.longitude;
//     // print("Latitude: $latitude, Longitude: $longitude");
//     //
//     // // Reverse Geocoding: Convert LatLng to Address
//     // List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//     //
//     // String formattedAddress = "Unknown Location";
//     // if (placemarks.isNotEmpty) {
//     //   Placemark place = placemarks.first;
//     //   formattedAddress = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//     // }
//     //
//     // if(kDebugMode) print("Current Address: $formattedAddress");
//
//     return {
//       "formattedAddress": "formattedAddress",
//       "lat": "latitude",
//       "long": "longitude"
//     };
//   } catch (e) {
//     if(kDebugMode) print("Error getting location: $e");
//     return null;
//   }
// }
