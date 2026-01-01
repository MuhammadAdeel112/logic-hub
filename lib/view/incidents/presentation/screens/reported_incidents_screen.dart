import 'package:divine_employee_app/core/common%20widgets/resueable_search_widget.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import '../../../../config/routes/page_transition.dart';
import '../../../../api_provider/get_incident_provider.dart';
import 'view_reported_incidents_screen.dart';

class ReportedIncidentsScreen extends StatefulWidget {
  const ReportedIncidentsScreen({Key? key});

  @override
  State<ReportedIncidentsScreen> createState() =>
      _ReportedIncidentsScreenState();
}

class _ReportedIncidentsScreenState extends State<ReportedIncidentsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetIncidentProvider>(context, listen: false).fetchIncidents();
    // context.read<GetIncidentProvider>().fetchIncidents();
  }

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Building ReportedIncidentsScreen");

    return ReuseableScaffoldScreen(
      appBarTitle: 'Reported Incidents',
      content: Consumer<GetIncidentProvider>(
        builder: (context, getIncidentProvider, _) {
          if (getIncidentProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (getIncidentProvider.hasError) {
            return Text('Error: ${getIncidentProvider.errorMessage}');
          } else {
            return Column(children: [
              ResueableSearchWidget(
                onChanged: (query) {
                  getIncidentProvider.searchIncidents(query);
                },
                searchController: _searchController,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getIncidentProvider.incidents.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideTransitionPage(
                            page: ViewReportedIncidentScreen(
                              incident: getIncidentProvider.incidents[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: AppConstants.kcwhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: AppConstants.kShadows,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getIncidentProvider
                                          .incidents[index].clientName,
                                      style: AppConstants
                                          .kTextStyleMediumBoldBlack,
                                    ),
                                    Text(
                                      getIncidentProvider
                                              .incidents[index].time.day
                                              .toString() +
                                          '/' +
                                          getIncidentProvider
                                              .incidents[index].time.month
                                              .toString() +
                                          '/' +
                                          getIncidentProvider
                                              .incidents[index].time.year
                                              .toString(),
                                      style:
                                          AppConstants.kTextStyleMediumBoldGrey,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getIncidentProvider
                                          .incidents[index].description,
                                      style:
                                          AppConstants.kTextStyleMediumBoldGrey,
                                    ),
                                    Text(
                                      formatDateTime(getIncidentProvider
                                          .incidents[index].time),
                                      style:
                                          AppConstants.kTextStyleMediumBoldGrey,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text(
                                      'Action: ' +
                                          getIncidentProvider
                                              .incidents[index].action,
                                      style:
                                          AppConstants.kTextStyleSmallBoldBlack,
                                    ),
                                    Text(
                                      'Incident Type: ' +
                                          getIncidentProvider
                                              .incidents[index].type,
                                      style:
                                          AppConstants.kTextStyleSmallBoldBlack,
                                    ),
                                    SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
