// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../widgets/my_approved_job_widget.dart';
import '../widgets/my_jobs_tabbar_widget.dart';
import '../widgets/my_unapproved_job_widget.dart';

class CompletedJobsScreen extends StatefulWidget {

  final animateTo;
   CompletedJobsScreen({
    Key? key,
     this.animateTo,
  }) : super(key: key);

  @override
  State<CompletedJobsScreen> createState() => _CompletedJobsScreenState();
}

class _CompletedJobsScreenState extends State<CompletedJobsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if(widget.animateTo != null){
      _tabController.animateTo(widget.animateTo);
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Completed Jobs',
      content: Column(
        children: [
          MyJobsTabBarWidget(
              firstTabText: 'Approved',
              secondTabText: 'Un-Approved',
              tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MyApprovedJobWidget(),
                MyUnApprovedJobWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
