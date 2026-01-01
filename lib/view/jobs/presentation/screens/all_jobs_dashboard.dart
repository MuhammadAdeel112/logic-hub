import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/my_completed_job_widget.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/my_uncompleted_job_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../widgets/my_approved_job_widget.dart';
import '../widgets/my_unapproved_job_widget.dart';

class AllJobsScreen extends StatefulWidget {
  final animateTo;
  AllJobsScreen({
    Key? key,
    this.animateTo,
  }) : super(key: key);

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (widget.animateTo != null) {
      _tabController =
          TabController(length: 4, vsync: this, initialIndex: widget.animateTo);
    } else {
      _tabController = TabController(length: 4, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'All Jobs',
      content: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: AppConstants.kcblackColor,
              labelColor: AppConstants.kcwhiteColor,
              indicator: ShapeDecoration(
                gradient: AppConstants.kgradientButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Un-Approved'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Waiting for review'),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: 'Approved')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Current'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MyUnApprovedJobWidget(),
                  MyCompletedJobWidget(),
                  MyApprovedJobWidget(),
                  MyUnCompletedJobWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
