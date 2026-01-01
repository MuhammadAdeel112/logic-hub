import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/view/earnings/presentation/widgets/list_of_paid_earning_widget.dart';
import 'package:divine_employee_app/view/earnings/presentation/widgets/list_of_unpaid_earning_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/earning_tabbar_widget.dart';
import '../widgets/inprocess_earning_widget.dart';

class EarningsDashboard extends StatefulWidget {
  const EarningsDashboard({super.key});

  @override
  State<EarningsDashboard> createState() => _EarningsDashboardState();
}

class _EarningsDashboardState extends State<EarningsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Earnings',
      content: Column(
        children: [
          EarningsTabBarWidget(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                InProcessEarningWidget(),
                ListOfUnPaidEarningWidget(),
                ListOfPaidEarningWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
