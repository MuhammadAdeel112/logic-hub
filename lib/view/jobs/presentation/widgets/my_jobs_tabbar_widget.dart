import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class MyJobsTabBarWidget extends StatelessWidget {
  final firstTabText;
  final secondTabText;
  MyJobsTabBarWidget({
    required this.firstTabText,
    required this.secondTabText,
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
          gradient: AppConstants.kgradientButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Tab(
                  text: firstTabText,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: Tab(
                text: secondTabText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
