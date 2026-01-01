import 'dart:io';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReuseableViewImageFullScreen extends StatelessWidget {
  final String? imageUrl;

  const ReuseableViewImageFullScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: getImageWidget(imageUrl),
        ),
      ),
    );
  }

  Widget getImageWidget(String? imageUrl) {
    print('::: image url in ffull screen${imageUrl}');
    if (imageUrl != null) {
      if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
        // If it starts with 'http' or 'https', it's a network image
        return Image.network(
          imageUrl,
          fit: BoxFit.contain,
        );
      } else {
        // Assume it's a local file image
        return Image.file(
          // You might want to check if the file exists before using it
          File(imageUrl),
          fit: BoxFit.contain,
        );
      }
    } else {
      // Default to the user icon if imageUrl is null
      return Image.asset(
        AppConstants.userIconPath,
        fit: BoxFit.contain,
      );
    }
  }
}
