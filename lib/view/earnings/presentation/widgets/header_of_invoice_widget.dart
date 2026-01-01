
// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_constants.dart';

// class HeaderOfInvoiceWidget extends StatelessWidget {
//   const HeaderOfInvoiceWidget({
//     super.key,
//     required this.isPaid,
//   });

//   final bool isPaid;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height / 8,
//                   maxWidth: MediaQuery.of(context).size.width / 3),
//               decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(width: 0.60, color: Color(0xFFEBEFF6)),
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                   shadows: AppConstants.kShadows),
//               child: Center(
//                 child: Image.asset(
//                   AppConstants.appLogoBgPath,
//                 ),
//               )),
//           Row(
//             children: [
//               Text(
//                 isPaid ? 'Paid' : 'Un-Paid',
//                 style: AppConstants.kTextStyleMediumBoldBlack,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 4.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: AppConstants.kcprimaryColor,
//                       borderRadius: BorderRadius.circular(9)),
//                   padding: EdgeInsets.all(4),
//                   child: isPaid
//                       ? Icon(
//                           Icons.check_circle,
//                           size: 15,
//                           color: AppConstants.kcwhiteColor,
//                         )
//                       : Image.asset(
//                           AppConstants.AlertIconPath,
//                           height: 15,
//                           color: AppConstants.kcwhiteColor,
//                         ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';

class HeaderOfInvoiceWidget extends StatelessWidget {
  const HeaderOfInvoiceWidget({
    super.key,
    required this.isPaid,
    required this.startDate,
    required this.endDate,
  });

  final bool isPaid;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 9,
                      maxWidth: MediaQuery.of(context).size.width / 3),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.60, color: Color(0xFFEBEFF6)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppConstants.appLogoBgPath,
                    ),
                  )),

              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        isPaid ? 'Paid' : 'Un-Paid',
                        style: AppConstants.kTextStyleMediumBoldBlack,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppConstants.kcprimaryColor,
                              borderRadius: BorderRadius.circular(9)),
                          padding: EdgeInsets.all(4),
                          child: isPaid
                              ? Icon(
                                  Icons.check_circle,
                                  size: 15,
                                  color: AppConstants.kcwhiteColor,
                                )
                              : Image.asset(
                                  AppConstants.AlertIconPath,
                                  height: 15,
                                  color: AppConstants.kcwhiteColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          Text(
                            'Date',
                            style:
                                AppConstants.kTextStyleMediumBoldBlack,
                          )
                        ],
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'From: ',
                          style: AppConstants.kTextStyleMediumBoldGrey,
                        ),
                        TextSpan(
                          text: formatDateTime(startDate),
                          style: AppConstants.kTextStyleSmallBoldBlack,
                        ),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'To: ',
                          style: AppConstants.kTextStyleMediumBoldGrey,
                        ),
                        TextSpan(
                          text: formatDateTime(endDate),
                          style: AppConstants.kTextStyleSmallBoldBlack,
                        ),
                      ]))
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
