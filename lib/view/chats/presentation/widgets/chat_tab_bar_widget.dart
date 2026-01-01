
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class ChatTabBarWidget extends StatelessWidget {
  const ChatTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      height: MediaQuery.of(context).size.height / 17,
      padding: const EdgeInsets.only(top: 6, left: 6, right: 16, bottom: 6),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, -0.04),
          end: Alignment(-1, 0.04),
          colors: [Color(0xFFD7D8E8), Color(0x3FD4D7F3)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: TabBar(
        
        controller: _tabController,
        unselectedLabelColor: AppConstants.kcblackColor,
        labelColor: AppConstants.kcblackColor,
        dividerColor: Colors.transparent,
        indicator: ShapeDecoration(
          // gradient: AppConstants.kgradientButton,
          color: AppConstants.kcwhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: FittedBox(
              child: Tab(
                text: 'Chats',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: FittedBox(
              child: Tab(
                text: 'Groups',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
