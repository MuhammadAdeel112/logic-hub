
// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_constants.dart';

// class MyScheduleWidget extends StatelessWidget {
//   MyScheduleWidget({
//     super.key,
//   });
//   final List<Color> containerColors = [
//     Color(0xFFFF6C6C),
//     Color(0xFF79E2A9),
//     Color(0xFFFFCD93),
//     // Add more colors as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       EasyDateTimeLine(
//           initialDate: DateTime.now(),
//           onDateChange: (selectedDate) {
//             //`selectedDate` the new date selected.
//           },
//           activeColor: AppConstants.kcprimaryColor,
//           headerProps: const EasyHeaderProps(
//             showMonthPicker: false,
//             showSelectedDate: false,
//             monthPickerType: MonthPickerType.switcher,
//             selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
//           ),
//           dayProps: EasyDayProps(
//             activeDayStyle: DayStyle(
//               decoration: BoxDecoration(
//                 color: AppConstants.kcprimaryColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             inactiveDayStyle: DayStyle(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             dayStructure: DayStructure.dayStrDayNum,
//           )),
//       // ResubaleSmallButton(
//       //     onpress: () {},
//       //     text: 'text',
//       //     bgColor: AppConstants.kcprimaryColor,
//       //     textStyle: AppConstants.kTextStyleMediumBoldBlack),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 18),
//           child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 // Use index to cycle through the colors
//                 final colorIndex = index % containerColors.length;
//                 final containerColor = containerColors[colorIndex];
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 18),
//                   child: Container(
//                     decoration: ShapeDecoration(
//                       color: AppConstants.kcwhiteColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       shadows: AppConstants.kShadows,
//                     ),
//                     child: Row(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width / 21,
//                               height: MediaQuery.of(context).size.height / 15,
//                               decoration: ShapeDecoration(
//                                 //change me
//                                 color: containerColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     bottomLeft: Radius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment
//                                     .start, // Align text to the left
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 5,
//                                         child: Text(
//                                           'Start Time:',
//                                           style: AppConstants
//                                               .kTextStyleMediumBoldGrey,
//                                         ),
//                                       ),
//                                       Text(
//                                         '8 AM',
//                                         style: AppConstants
//                                             .kTextStyleMediumBoldBlack,
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 5,
//                                         child: Text(
//                                           'End Time:',
//                                           style: AppConstants
//                                               .kTextStyleMediumBoldGrey,
//                                         ),
//                                       ),
//                                       Text(
//                                         '6 PM',
//                                         style: AppConstants
//                                             .kTextStyleMediumBoldBlack,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       )
//     ]);
//   }
// }
