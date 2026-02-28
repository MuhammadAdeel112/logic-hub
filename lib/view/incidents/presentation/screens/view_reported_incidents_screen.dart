import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_view_image_full_screen.dart';
import 'package:divine_employee_app/models/get_incident_model.dart';
import 'package:divine_employee_app/view/availability/presentation/screens/requested_availbility_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class ViewReportedIncidentScreen extends StatelessWidget {
  final GetIncidentModel incident;
  ViewReportedIncidentScreen({required this.incident});
  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: 'Detials', // Note: Same as your code typo 'Detials'
      content: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Container(
                decoration: ShapeDecoration(
                    color: AppConstants.kcwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: AppConstants.kShadows),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Client Name: ',
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackDecription,
                                    ),
                                    TextSpan(
                                        text: incident.clientName,
                                        style: AppConstants
                                            .kTextStyleSmallBoldGreen),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Staff Name: ',
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackDecription,
                                    ),
                                    TextSpan(
                                        text: incident.staffName,
                                        style: AppConstants
                                            .kTextStyleSmallBoldGreen),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Designation: ',
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackDecription,
                                    ),
                                    TextSpan(
                                        text: incident.staffDesignation,
                                        style: AppConstants
                                            .kTextStyleSmallBoldGreen),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.location_on,
                              size: 15,
                            ),
                          ),
                          Expanded( // Added Expanded to prevent text overflow
                            child: Text(
                              incident.location,
                              style: AppConstants.kTextStyleMediumRegularGrey,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      // date time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Date: ',
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                                TextSpan(
                                    text: incident.time.day.toString() +
                                        '/' +
                                        incident.time.month.toString() +
                                        '/' +
                                        incident.time.year.toString(),
                                    style: AppConstants
                                        .kTextStyleSmallRegularBlackoverflowcontrol),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Time: ',
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                                TextSpan(
                                    text: formatDateTime(incident.time),
                                    style: AppConstants
                                        .kTextStyleSmallRegularBlackoverflowcontrol),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Divider(
                        color: Colors.transparent,
                      ),
                      // job description
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Staff FeedBack',
                                style: AppConstants.kTextStyleMediumBoldBlack,
                              ),
                            ],
                          ),
                          SizedBox(),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height /
                                  6, // Set the maximum height you desire
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                incident.description,
                                style: AppConstants.kTextStyleSmallRegularBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      // job description
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Incident Type',
                                style: AppConstants.kTextStyleMediumBoldBlack,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height /
                                  6, // Set the maximum height you desire
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                incident.type,
                                style: AppConstants.kTextStyleSmallRegularBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      // Staff Feedback
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Action Taken By Staff',
                                style: AppConstants.kTextStyleMediumBoldBlack,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height /
                                  6, // Set the maximum height you desire
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                incident.action,
                                style: AppConstants.kTextStyleSmallRegularBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      // --- UPDATED IMAGE SECTION ---
                      Row(
                        children: [
                          // 🔥 Check if image exists before showing
                          if (incident.imageUrl != null && incident.imageUrl!.isNotEmpty)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SlideTransitionPage(
                                        page: ReuseableViewImageFullScreen(
                                          imageUrl: incident.imageUrl!, // ! confirms not null
                                        )));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.height / 9,
                                  decoration: ShapeDecoration(
                                      color: AppConstants.kcwhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadows: AppConstants.kShadows),
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                      child: Image.network(
                                        incident.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.broken_image, color: Colors.grey),
                                      ))),
                            )
                          else
                          // 🔥 Placeholder if image is null
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}