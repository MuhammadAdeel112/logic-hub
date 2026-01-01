import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // Function to dismiss the keyboard
  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void fietdFocusChange(
      BuildContext context, 
      FocusNode current, 
      FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      // textColor: AppConstants.kcsecondaryColor,
      // backgroundColor: AppConstants.kcgreenbgColor
    );
  }

  static showFlushbar( String message, BuildContext context) {
    Flushbar(
      // title: title,
      // titleColor: AppConstants.kcsecondaryColor,
      message: message,
      // messageColor: AppConstants.kcsecondaryColor,
      duration: Duration(seconds: 2),
      reverseAnimationCurve: Curves.easeInBack,
      forwardAnimationCurve: Curves.linear,
      // backgroundColor: AppConstants.kcgreenbgColor,
      padding: EdgeInsets.all(12),
      maxWidth: MediaQuery.of(context).size.width/1.1,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(20),
      positionOffset: 20,
    )..show(context);
  }

  /// Launches the phone dialer with the provided [phoneNumber].
  static Future<void> launchPhoneDialer(BuildContext context, String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      showFlushbar(
          'Unable to launch phone dialer',
          context);
    }
  }

  Future<void> openGoogleMapsWithAddress(BuildContext context, String address) async {
    final Uri googleMapsUri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$address");

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      showFlushbar('Could not launch Google Maps', context);
      throw 'Could not launch Google Maps';
    }
  }



  // static snackBar(String message, BuildContext context) {
  //   return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       backgroundColor: AppConstants.kcgreenbgColor,
  //       content: Text(
  //         message,
  //         style: TextStyle(color: AppConstants.kcsecondaryColor),
  //       )));
  // }
}
