
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class AvailabilityTabBarWidget extends StatelessWidget {
  const AvailabilityTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: _tabController,
        unselectedLabelColor: AppConstants.kcblackColor,
        labelColor: AppConstants.kcwhiteColor,
        indicator: ShapeDecoration(
          // color: Colors.amber,
          gradient:AppConstants.kgradientButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: FittedBox(
              child: Tab(
                text: 'Schedule',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: Tab(
                text: 'Availability',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
