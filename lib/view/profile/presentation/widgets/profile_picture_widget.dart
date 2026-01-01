// import 'dart:io';
// import 'package:divine_employee_app/core/constants/app_constants.dart';
// import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../api_provider/data_provider_for_employee_profile.dart';
// import '../../../../core/common widgets/reuseable_view_image_full_screen.dart';

// class ProfilePictureWidget extends StatelessWidget {
//   const ProfilePictureWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final employeeData =
//         Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
//     // var networkImage=  employeeData.employeeProfile?.employee.imageUrl;
//     // Use the ProfileImageProvider to get the selected image path
//     final profileImageProvider =
//         Provider.of<ProfileImageProviderClass>(context, listen: false);
//     final selectedImagePath = profileImageProvider.ProfileImagePath;
//     ImageProvider<Object> userIcon = AssetImage(AppConstants.userIconPath);

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: InkWell(
//           onTap: () {
//             String? imageToShow = getImageToShow(selectedImagePath,
//                 employeeData.employeeProfile!.employee.imageUrl);

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     ReuseableViewImageFullScreen(imageUrl: imageToShow),
//               ),
//             );
//           },
//           child: Stack(
//             children: [
//               selectedImagePath != null
//                   ? Container(
//                       decoration: ShapeDecoration(
//                         shape: const OvalBorder(
//                           side: BorderSide(width: 4.50, color: Colors.white),
//                         ),
//                         shadows: AppConstants.kShadows,
//                       ),
//                       child: CircleAvatar(
//                         radius: 60,
//                         // Conditionally display the selected image or the network image
//                         backgroundImage: FileImage(File(selectedImagePath)),
//                       ),
//                     )
//                   : Container(
//                       decoration: ShapeDecoration(
//                         shape: const OvalBorder(
//                           side: BorderSide(width: 4.50, color: Colors.white),
//                         ),
//                         shadows: AppConstants.kShadows,
//                       ),
//                       child: CircleAvatar(
//                         radius: 60,
//                         // Conditionally display the selected image or the network image
//                         backgroundImage: employeeData.employeeProfile != null &&
//                                 employeeData.employeeProfile!.employee.imageUrl
//                                     .isNotEmpty
//                             ? NetworkImage(
//                                 employeeData.employeeProfile!.employee.imageUrl,
//                               )
//                             : userIcon,
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String? getImageToShow(String? localImagePath, String? networkImageUrl) {
//     if (localImagePath != null) {
//       // If there is a local file image, use it
//       return localImagePath;
//     } else if (networkImageUrl != null) {
//       // If there is a network image, use it
//       return networkImageUrl;
//     } else {
//       // If neither local nor network image is available, use the default user icon
//       return AppConstants.userIconPath;
//     }
//   }
// }


import 'dart:io';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../../../../core/common widgets/reuseable_view_image_full_screen.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Consumer<DataProviderForEmployeeProfile>(
          builder: (context, employeeData, child) {
            return Consumer<ProfileImageProviderClass>(
              builder: (context, profileImageProvider, child) {
                final selectedImagePath = profileImageProvider.ProfileImagePath;
                ImageProvider<Object> userIcon = AssetImage(AppConstants.userIconPath);

                return InkWell(
                  onTap: () {
                    String? imageToShow = getImageToShow(
                      selectedImagePath,
                      employeeData.employeeProfile?.employee.imageUrl,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReuseableViewImageFullScreen(imageUrl: imageToShow),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      selectedImagePath != null
                          ? Container(
                              decoration: ShapeDecoration(
                                shape: const OvalBorder(
                                  side: BorderSide(width: 4.50, color: Colors.white),
                                ),
                                shadows: AppConstants.kShadows,
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                // Conditionally display the selected image or the network image
                                backgroundImage: FileImage(File(selectedImagePath)),
                              ),
                            )
                          : Container(
                              decoration: ShapeDecoration(
                                shape: const OvalBorder(
                                  side: BorderSide(width: 4.50, color: Colors.white),
                                ),
                                shadows: AppConstants.kShadows,
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                // Conditionally display the selected image or the network image
                                backgroundImage: employeeData.employeeProfile != null &&
                                    employeeData.employeeProfile!.employee.imageUrl
                                        .isNotEmpty
                                    ? NetworkImage(
                                        employeeData.employeeProfile!.employee.imageUrl,
                                      )
                                    : userIcon,
                              ),
                            ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String? getImageToShow(String? localImagePath, String? networkImageUrl) {
    if (localImagePath != null) {
      return localImagePath;
    } else if (networkImageUrl != null) {
      return networkImageUrl;
    } else {
      return AppConstants.userIconPath;
    }
  }
}
