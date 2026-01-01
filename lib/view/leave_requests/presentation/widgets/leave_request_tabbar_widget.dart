
// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_constants.dart';

// class LeaveRequestTabBarWidget extends StatelessWidget {
//   const LeaveRequestTabBarWidget({
//     super.key,
//     required TabController tabController,
//   }) : _tabController = tabController;

//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TabBar(
//         controller: _tabController,
//         unselectedLabelColor: AppConstants.kcblackColor,
//         labelColor: AppConstants.kcwhiteColor,
//         indicator: ShapeDecoration(
//           // color: Colors.amber,
//           gradient:AppConstants.kgradientButton,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         tabs: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: FittedBox(
//               child: Tab(
//                 text: 'Paid Leave',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: FittedBox(
//               child: Tab(
//                 text: 'Un-Paid Leave',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
