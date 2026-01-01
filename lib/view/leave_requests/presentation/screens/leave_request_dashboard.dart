import 'package:divine_employee_app/api_provider/get_paid_leave_hours.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/leave_requests/presentation/provider/date_range_provider.dart';
import 'package:divine_employee_app/view/leave_requests/presentation/widgets/date_range_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../core/common widgets/reuseable_sccafold_screen.dart';
import '../../../../api_provider/leave_request_provider.dart';
import '../provider/select_leave_type_provider.dart';
import '../widgets/leave_request_drop_down_widget.dart';
import 'package:intl/intl.dart'; // For formatting dates


class LeaveRequestsDashboard extends StatefulWidget {
  const LeaveRequestsDashboard({super.key});

  @override
  State<LeaveRequestsDashboard> createState() => _LeaveRequestsDashboardState();
}

class _LeaveRequestsDashboardState extends State<LeaveRequestsDashboard> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController hoursTextEditingController = TextEditingController();
  TextEditingController DescriptionTextEditingController =
      TextEditingController();
  String? availableHours = "0";
  late Future<void> _availableHoursFuture;
  @override
  void initState() {
    super.initState();
    _availableHoursFuture = _initializeAvailableHours();
  }

  Future<void> _initializeAvailableHours() async {
    availableHours = await GetPaidLeaveHours().getPaidHours();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectTypeProvider = Provider.of<SelectLeaveTypeProvider>(
      context,
    );
    final leaveRequestProvider = Provider.of<LeaveRequestProvider>(context);
    final dateRangeProvider = Provider.of<DateRangeProvider>(context);

    return ReuseableScaffoldScreen(
        appBarTitle: 'Leave Request',
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: ShapeDecoration(
                          color: AppConstants.kcwhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: AppConstants.kShadows),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Leave',
                            style: AppConstants.kTextStyleMediumBoldBlack,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.height / 17,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF334155)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: TextFormField(
                              controller: titleTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Enter title",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // document details
                          Divider(
                            color: Colors.transparent,
                          ),
                          LeaveRequestDropdownWidget(),
                          Text(
                            'Select Date Range',
                            style: AppConstants.kTextStyleMediumBoldBlack,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          DateRangePicker(),
                          Consumer<SelectLeaveTypeProvider>(
                            builder: (context, provider, child) {
                              if (provider.type == "paid") {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        'Leave Hours',
                                        style: AppConstants.kTextStyleMediumBoldBlack,
                                      ),
                                      // Divider(
                                      //   color: Colors.transparent,
                                      // ),
                                      FutureBuilder(
                                        future: _availableHoursFuture,
                                        builder: (context, snapshot) {
                                          return Text(
                                            "You can have $availableHours hours paid leave",
                                            style: TextStyle(
                                                color: Colors.red, fontSize: 14),
                                          );
                                        }
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Container(
                                        // width: MediaQuery.of(context).size.width / 1.2,
                                        height: MediaQuery.of(context).size.height / 17,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1, color: Color(0xFF334155)),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: hoursTextEditingController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "Enter hours",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox
                                  .shrink(); // Returns an empty widget if not "paid"
                            },
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),

                          Text(
                            'Details',
                            style: AppConstants.kTextStyleMediumBoldBlack,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF334155)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                            child: TextFormField(
                              controller: DescriptionTextEditingController,
                              textAlign: TextAlign.start,
                              maxLength: 430,
                              maxLines: 5,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the Description!';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                // setState(() {
                                //   description = value;
                                // });
                              },
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              FutureBuilder<Map<String, dynamic>>(
                                future:
                                    Provider.of<LeaveRequestProvider>(context)
                                        .leaveRequestFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      Provider.of<LeaveRequestProvider>(context)
                                          .isLoading) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ); // Show loading indicator
                                  } else {
                                    return ReuseableGradientButton(
                                      title: 'Submit',
                                      onpress: () async {
                                        DateTime? startDateRange = dateRangeProvider.startDate;
                                        DateTime? endDateRange = dateRangeProvider.endDate;
                                        final formatter = DateFormat.yMMMd();
                                        String startDate = "";
                                        String endDate = "";
                                        if (startDateRange != null && endDateRange != null) {
                                          startDate = formatter.format(startDateRange);
                                          endDate = formatter.format(endDateRange);
                                          if(kDebugMode){
                                            print("Start Date Range: $startDateRange");
                                            print("End Date Range: $endDateRange}");
                                            print("startDate $startDate");
                                            print("endDate $endDate");
                                          }
                                        } else {
                                          print("No range selected");
                                        }
                                        if (titleTextEditingController
                                            .text.isEmpty) {
                                          Utils.showFlushbar(
                                              'Please Enter Title', context);
                                        } else if (DescriptionTextEditingController
                                            .text.isEmpty) {
                                          Utils.showFlushbar(
                                              'Please Enter Details', context);
                                        } else if (startDateRange == null || endDateRange == null) {
                                          Utils.showFlushbar(
                                              'Please Enter Date', context);
                                        }else if (selectTypeProvider
                                                .type.isEmpty ||
                                            selectTypeProvider.type ==
                                                'Select') {
                                          Utils.showFlushbar(
                                              'Please select type', context);
                                        } else if (hoursTextEditingController
                                            .text.isEmpty && selectTypeProvider.type ==
                                            'paid') {
                                          Utils.showFlushbar(
                                              'Please Enter Hours', context);
                                        } else {
                                          if (selectTypeProvider.type ==
                                              'free') {
                                            await leaveRequestProvider.submitLeaveRequest(
                                              selectTypeProvider.type,
                                              titleTextEditingController.text,
                                              DescriptionTextEditingController.text,
                                              startDate: startDate,
                                              endDate: endDate,
                                            );
                                            // Show the result dialog after the submission is complete
                                            _showResultDialog(
                                                context,
                                                leaveRequestProvider
                                                    .leaveRequestFuture);
                                            dateRangeProvider.clearDateRange();
                                            selectTypeProvider.clearType();
                                            Future.delayed(Duration(seconds: 1)).then((value){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            });
                                          } else {
                                            if (double.parse(availableHours!) <
                                                double.parse(
                                                    hoursTextEditingController
                                                        .text)) {
                                              Utils.showFlushbar(
                                                  'You can not select more than available hours',
                                                  context);
                                              return;
                                            } else {
                                              await leaveRequestProvider
                                                  .submitLeaveRequest(
                                                selectTypeProvider.type,
                                                titleTextEditingController.text,
                                                DescriptionTextEditingController
                                                    .text,
                                                requestedLeaveHours: hoursTextEditingController
                                                    .text.toString(),
                                                startDate: startDate,
                                                endDate: endDate,
                                              );
                                              // Show the result dialog after the submission is complete
                                              _showResultDialog(
                                                  context,
                                                  leaveRequestProvider
                                                      .leaveRequestFuture);
                                              dateRangeProvider.clearDateRange();
                                              selectTypeProvider.clearType();
                                              Future.delayed(Duration(seconds: 1)).then((value){
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            }
                                          }

                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ))),
            ],
          ),
        ));
  }

  void _showResultDialog(
      BuildContext context, Future<Map<String, dynamic>> future) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Text('Submitting...'),
                content: CircularProgressIndicator(),
              );
            } else {
              // Display the result dialog based on the response
              bool success = snapshot.data?['success'] ?? false;
              String message = snapshot.data?['message'] ?? 'Unknown error';

              return AlertDialog(
                title: Text(success ? 'Success' : 'Error'),
                content: Text(message),
                actions: <Widget>[
                  ReuseableGradientButton(
                    onpress: () {
                      Navigator.of(context).pop();
                    },
                    width: MediaQuery.of(context).size.width / 4,
                    title: 'Ok',
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }


}
