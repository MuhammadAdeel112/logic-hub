// import 'package:divine_employee_app/core/constants/app_constants.dart';
// import 'package:divine_employee_app/view/registration/state/select_employee_type_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class SelectEmployeeTypeDropdownWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final selectEmployeeProvider = Provider.of<SelectEmployeeTypeProvider>(
//       context,
//     );
//     List<String> items = ['Select Type', 'permanent', 'casual'];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(bottom: 8),
//           child: Text('Employee Type',
//               style: AppConstants.kTextStyleMediumRegularBlack),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: 26),
//           child: Container(
//             width: MediaQuery.of(context).size.width / 2.5,
//             height: MediaQuery.of(context).size.height / 17,
//             decoration: AppConstants.KContainerStyleForTextFormField,
//             child: Center(
//               child: DropdownButton<String>(
//                 alignment: Alignment.centerRight,
//                 borderRadius: BorderRadius.circular(29),
//                 dropdownColor:
//                     AppConstants.kcwhiteColor, // Use your desired color
//                 padding: EdgeInsets.all(8),
//                 underline: SizedBox(),
//                 isExpanded: true,
//                 icon: Icon(Icons.keyboard_arrow_down_sharp),
//                 value: selectEmployeeProvider.type, // Current selected item
//                 onChanged: (String? newValue) {
//                   selectEmployeeProvider.setType(newValue!);

//                   print("New Value $newValue");
//                 },
//                 items: items.map((String item) {
//                   return DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(item,
//                         style: AppConstants.ktextDropDownStyle),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
