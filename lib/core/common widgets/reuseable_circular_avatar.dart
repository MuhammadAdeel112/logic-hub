import 'dart:io';

import 'package:divine_employee_app/core/common%20widgets/reuseable_view_image_full_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReUseAbleRectangleImageAvatar extends StatelessWidget {
  const ReUseAbleRectangleImageAvatar({
    super.key,
    required this.image,
  });

  final image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ReuseableViewImageFullScreen(imageUrl: image),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 7,
        height: MediaQuery.of(context).size.height / 15.5,
        child: getImageWidget(image),
        
      ),
    );
  }
}

Widget getImageWidget(String? imageUrl) {
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
