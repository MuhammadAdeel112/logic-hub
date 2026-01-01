// import 'package:divine_employee_app/core/constants/app_constants.dart';
// import 'package:flutter/material.dart';

// import '../../../../core/common widgets/reuseable_gradient_button.dart';
// import 'leave_request_drop_down_widget.dart';

// class GenerateLeaveRequestWidget extends StatelessWidget {
//   TextEditingController titleTextEditingController = TextEditingController();
//   TextEditingController DescriptionTextEditingController =
//       TextEditingController();
//   // final VoidCallback onPressed;

//   GenerateLeaveRequestWidget({
//     // required this.titleTextEditingController,
//     // required this.DescriptionTextEditingController,
//     // required this.onPressed,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//               child: Container(
//                   padding: EdgeInsets.all(18),
//                   decoration: ShapeDecoration(
//                       color: AppConstants.kcwhiteColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       shadows: AppConstants.kShadows),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Leave Title',
//                         style: AppConstants.kTextStyleMediumBoldBlack,
//                       ),
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       Container(
//                         // width: MediaQuery.of(context).size.width / 1.2,
//                         height: MediaQuery.of(context).size.height / 17,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         decoration: ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                             side:
//                                 BorderSide(width: 1, color: Color(0xFF334155)),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         child: TextFormField(
//                           controller: titleTextEditingController,
//                           decoration: InputDecoration(
//                             hintText: "Enter title",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       // document details
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       LeaveRequestDropdownWidget(),
                     
                     
//                       Text(
//                         'Details',
//                         style: AppConstants.kTextStyleMediumBoldBlack,
//                       ),
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       Container(
//                         decoration: ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                             side:
//                                 BorderSide(width: 1, color: Color(0xFF334155)),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
//                         child: TextFormField(
//                           controller: DescriptionTextEditingController,
//                           textAlign: TextAlign.start,
//                           maxLength: 430,
//                           maxLines: 5,
//                           decoration: InputDecoration(border: InputBorder.none),
//                           keyboardType: TextInputType.text,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter the Description!';
//                             }
//                             return null;
//                           },
//                           onFieldSubmitted: (value) {
//                             // setState(() {
//                             //   description = value;
//                             // });
//                           },
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       Divider(
//                         color: Colors.transparent,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(),
//                           ReuseableGradientButton(
//                               title: 'Submit', onpress: (){
                                
//                               }),
//                         ],
//                       ),
//                     ],
//                   ))),
//         ],
//       ),
//     );
//   }
// }
