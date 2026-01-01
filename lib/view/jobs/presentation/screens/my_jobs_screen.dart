import 'package:flutter/material.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../widgets/my_completed_job_widget.dart';
import '../widgets/my_jobs_tabbar_widget.dart';
import '../widgets/my_uncompleted_job_widget.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
      appBarTitle: 'My Jobs',
      content: Column(
        children: [
          MyJobsTabBarWidget(
              firstTabText: 'Completed',
              secondTabText: 'Un-Completed',
              tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MyCompletedJobWidget(),
                MyUnCompletedJobWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
