import 'package:divine_employee_app/api_provider/job_update_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_small_button.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:flutter/material.dart';

import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../../../../models/assigned_jobs_model.dart';

typedef UpdateSuccessCallback = void Function(
    String updatedExtraAmount, String distanceTraveled);

class UpdateJobScreen extends StatefulWidget {
  final Job job;
  final UpdateSuccessCallback onUpdateSuccess;
  final extraDistance;
  final jobNotes;
  final extraAmount;
  final extraTime;
  final jobId;
  UpdateJobScreen({
    Key? key,
    required this.onUpdateSuccess,
    required this.extraDistance,
    required this.jobNotes,
    required this.extraAmount,
    required this.extraTime,
    required this.jobId,
    required this.job,
  }) : super(key: key);

  @override
  State<UpdateJobScreen> createState() => _UpdateJobScreenState();
}

class _UpdateJobScreenState extends State<UpdateJobScreen> {
  TextEditingController distanceTravelledController = TextEditingController();
  TextEditingController shiftNotesController = TextEditingController();
  TextEditingController extraAmountController = TextEditingController();
  TextEditingController extraTimeController = TextEditingController();
  @override
  void initState() {
    distanceTravelledController =
        TextEditingController(text: widget.extraDistance.toString());
    shiftNotesController =
        TextEditingController(text: widget.jobNotes.toString());
    extraAmountController =
        TextEditingController(text: widget.extraAmount.toString());
    extraTimeController =
        TextEditingController(text: widget.extraTime.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<UpdateJobApiProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Update',
      content: Column(
        children: [
          //Distance Travelled
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distance Travelled ',
                style: AppConstants.kTextStyleMediumBoldGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 16,
                // width: MediaQuery.of(context).size.width / 3,
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: distanceTravelledController,
                      style: AppConstants.kTextStyleSmallRegularBlackDecription,
                      decoration: InputDecoration(
                        hintText: "Enter Kilometers",
                        // hintStyle:
                        //     AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Shift Notes',
                style: AppConstants.kTextStyleMediumBoldGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 16,
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      controller: shiftNotesController,
                      style: AppConstants.kTextStyleSmallRegularBlackDecription,
                      decoration: InputDecoration(
                        hintText: "Enter Notes",
                        // hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                        //  prefixIcon: Icon(
                        //    Icons.person,
                        //  ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Out of Pocket Expense',
                style: AppConstants.kTextStyleMediumBoldGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 16,
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: extraAmountController,
                      style: AppConstants.kTextStyleSmallRegularBlackDecription,
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        // hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                        //  prefixIcon: Icon(
                        //    Icons.person,
                        //  ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Extra Hour',
                style: AppConstants.kTextStyleMediumBoldGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 16,
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: extraTimeController,
                      style: AppConstants.kTextStyleSmallRegularBlackDecription,
                      decoration: InputDecoration(
                        hintText: "Enter Extra Hours",
                        // hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                        border: InputBorder.none,
                        //  prefixIcon: Icon(
                        //    Icons.person,
                        //  ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),

          Consumer<UpdateJobApiProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return value.isLoading
                  ? CircularProgressIndicator()
                  : ReuseableGradientSmallButton(
                      title: 'Update',
                      onpress: () async {
                        final result = await value.updateJob(
                            widget.jobId,
                            distanceTravelledController.text,
                            shiftNotesController.text,
                            extraAmountController.text,
                            extraTimeController.text);
                        if (result['success']) {
                          Utils.showToastMessage("Your Job is Updated");
                          Navigator.pop(context);
                          widget.onUpdateSuccess(extraAmountController.text,
                              distanceTravelledController.text);

                          print(':::Success');
                        } else {
                          print(':::failed');
                        }
                      });
            },
          )
        ],
      ),
    );
  }
}
