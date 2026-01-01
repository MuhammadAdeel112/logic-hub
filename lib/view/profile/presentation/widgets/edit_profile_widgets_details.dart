// import 'package:divine_employee_app/core/constants/app_constants.dart';
// import 'package:divine_employee_app/core/utils/utlis.dart';
// import 'package:divine_employee_app/api_provider/profile_update_api_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../core/common widgets/reuseable_gradient_button.dart';
// import '../../../../core/common widgets/reuseable_gradient_small_button.dart';
// import '../../../../api_provider/data_provider_for_employee_profile.dart';

// class EditProfileDetailsWidget extends StatelessWidget {
//   final TextEditingController _nameEditingController =
//       new TextEditingController();
//   // text: employeeData.employeeProfile!.employee.name);
//   final TextEditingController _phoneController = new TextEditingController();
//   // text: employeeData.employeeProfile!.employee.phone);
//   final TextEditingController _passwordController = new TextEditingController();
//   EditProfileDetailsWidget({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     final employeeData =
//         Provider.of<DataProviderForEmployeeProfile>(context, listen: false);

//     return Container(
//       margin: EdgeInsets.only(top: 80),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//           color: AppConstants.kcgreyColor,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(29), topRight: Radius.circular(29))),
//       child: SingleChildScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 13,
//             ),

//             // Edit  button
//             ReuseableGradientSmallButton(
//               title: 'Edit Image',
//               onpress: () {},
//             ),

//             // options
//             Padding(
//               padding: const EdgeInsets.only(top: 18.0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 decoration: ShapeDecoration(
//                   color: AppConstants.kcwhiteColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             //user name
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text('Username',
//                                   style:
//                                       AppConstants.kTextStyleMediumBoldBlack),
//                             ),
//                             //user name container
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: 12, left: 12, right: 12),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width / 1.5,
//                                 decoration: ShapeDecoration(
//                                   // color: AppConstants.kcwhiteColor,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         width: 0.50, color: Color(0xFFA8A8A8)),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: TextFormField(
//                                     controller: _nameEditingController,
//                                     decoration: InputDecoration(
//                                       hintText: "Your Name",
//                                       contentPadding: EdgeInsets.all(8),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text('Phone Number',
//                                   style:
//                                       AppConstants.kTextStyleMediumBoldBlack),
//                             ),
//                             //user name container
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: 12, left: 12, right: 12),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width / 1.5,
//                                 decoration: ShapeDecoration(
//                                   // color: AppConstants.kcwhiteColor,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         width: 0.50, color: Color(0xFFA8A8A8)),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: TextFormField(
//                                     controller: _phoneController,
//                                     decoration: InputDecoration(
//                                       hintText: "+61 234 578 879",
//                                       contentPadding: EdgeInsets.all(8),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             //user name
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 8),
//                               child: Text('Password',
//                                   style:
//                                       AppConstants.kTextStyleMediumBoldBlack),
//                             ),
//                             //user name container
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: 26, left: 16, right: 16),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width / 1.5,
//                                 decoration: ShapeDecoration(
//                                   // color: AppConstants.kcwhiteColor,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         width: 0.50, color: Color(0xFFA8A8A8)),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: TextFormField(
//                                     controller: _passwordController,
//                                     obscureText: true,
//                                     decoration: InputDecoration(
//                                         hintText: "••••••••",
//                                         // hintStyle: AppConstants.kTextStyleSmallBoldGrey,
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.all(8)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Consumer<ProfileUpdateApiProvider>(
//                               builder: (context, provider, child) {
//                                 return provider.isLoading
//                                     ? Center(
//                                         child: Padding(
//                                         padding: const EdgeInsets.all(13),
//                                         child: CircularProgressIndicator(),
//                                       ))
//                                     : Padding(
//                                         padding: const EdgeInsets.only(
//                                             right: 48, bottom: 12, left: 48.0),
//                                         child: ReuseableGradientButton(
//                                           onpress: () async {
//                                             // Check if the provider is not already loading
//                                             if (!provider.isLoading) {
//                                               // Show loading indicator
//                                               provider.isLoading = true;
//                                               try {
//                                                 // Call the updateProfile API
//                                                 Map<String, dynamic> response =
//                                                     await provider
//                                                         .updateProfile(
//                                                   name: _nameEditingController
//                                                       .text,
//                                                   phone: _phoneController.text,
//                                                   password:
//                                                       _passwordController.text,
//                                                   // imagePath: '/path/to/file', // imagePath is optional
//                                                 );
//                                                 if (response['success'] ==
//                                                     true) {
//                                                   print(
//                                                       'Profile Updated successfully');
//                                                   _showResultDialog(context,
//                                                       message:
//                                                           'Profile Updated  successfully');
//                                                 } else {
//                                                   print(
//                                                       'Error Profile Updated : ${response['message']}');
//                                                   Utils.showFlushbar(
//                                                       response['message'],
//                                                       context);
//                                                 }
//                                               } catch (e) {
//                                                 // Handle error, you can show an error dialog here
//                                                 print(
//                                                     'Error updating profile: $e');
//                                               } finally {
//                                                 // Hide loading indicator
//                                                 provider.isLoading = false;
//                                               }
//                                             }
//                                           },
//                                           title: 'Update',
//                                         ),
//                                       );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showResultDialog(BuildContext context, {required String message}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Success'),
//           content: Text(message),
//           actions: <Widget>[
//             ReuseableGradientButton(
//               onpress: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//               width: MediaQuery.of(context).size.width / 4,
//               title: 'Ok',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
