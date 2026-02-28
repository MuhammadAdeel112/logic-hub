import 'dart:io';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/models/assigned_jobs_model.dart';
import 'package:divine_employee_app/view/auth/presentation/state/bottom_app_bar_provider.dart';
import 'package:divine_employee_app/view/incidents/presentation/provider/select_date_time_provider_for_incident.dart';
import 'package:divine_employee_app/view/incidents/presentation/provider/select_incident_provider.dart';
import 'package:divine_employee_app/view/incidents/presentation/widgets/action_taken_by_staff_drop_down_widget.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/job_home_screen.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../../../../api_provider/incident_report_provider.dart';
import '../../../../core/data/response/status.dart';
import '../widgets/incident_type_drop_down_widget.dart';

class GenerateIncidentWithoutCurrentJobScreen extends StatefulWidget {
  const GenerateIncidentWithoutCurrentJobScreen({super.key});

  @override
  State<GenerateIncidentWithoutCurrentJobScreen> createState() =>
      _GenerateIncidentWithoutCurrentJobScreentate();
}

class _GenerateIncidentWithoutCurrentJobScreentate
    extends State<GenerateIncidentWithoutCurrentJobScreen> {
  var timeNow = DateTime.now();
  TextEditingController descriptionController = TextEditingController();
  String? JobId;
  String? clientName;
  String? shiftManagerName;
  String? shiftManagerDesignation;
  String? location;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final assignedJobsProvider = Provider.of<AssignedJobsProvider>(context);
    final assignedJobs = assignedJobsProvider.assignedJobs?.job;

    final time = Provider.of<selectDateTimeForIncidentProvider>(context);
    final selectIncidentTypeProvider =
    Provider.of<SelectIncidentTypeProvider>(context);
    final actionTakenByStaffProvider =
    Provider.of<ActionTakenByStaffProvider>(context);

    ///
    final incidentReportProvider = Provider.of<IncidentReportProvider>(context);
    final incidentImageProvider =
    Provider.of<IncidentImageProviderClass>(context);
    final selectedImagePath = incidentImageProvider.IncidentImagePath;

    return ReuseableScaffoldScreen(
      appBarTitle: 'Report an Incident',
      content: Consumer(builder: (BuildContext context, value, Widget? child) {
        switch (assignedJobsProvider.apiResponse.status) {
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
          case Status.COMPLETED:
            final jobList =
            assignedJobs!.where((job) => job.status == 'pending').toList();
            if (isSelected == false) {
              Future.microtask(() => showListOfAllJobsDialog(context, jobList)).then((value) {
                setState(() {
                  isSelected = true;
                });
              });
            }
            return GestureDetector(
              onTap: () {
                Utils.dismissKeyboard(context);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    decoration: ShapeDecoration(
                        color: AppConstants.kcwhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: AppConstants.kShadows),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Shift Id
                                  GestureDetector(
                                    onTap: () {
                                      final jobList = assignedJobs
                                          .where(
                                              (job) => job.status == 'pending')
                                          .toList();

                                      showListOfAllJobsDialog(context, jobList);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Job Id',
                                          style: AppConstants
                                              .kTextStyleMediumBoldGrey,
                                        ),
                                        Container(
                                          // height: MediaQuery.of(context).size.height / 16,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2.5,
                                          decoration: ShapeDecoration(
                                            color: AppConstants.kcwhiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                            shadows: AppConstants.kShadows,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Center(
                                              child: TextFormField(
                                                readOnly: true,
                                                // controller: nameController,
                                                decoration: InputDecoration(
                                                  hintText: JobId,
                                                  hintStyle: AppConstants
                                                      .kTextStyleSmallBoldGrey,
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //Client Name
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Client Name',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        decoration: ShapeDecoration(
                                          color: AppConstants.kcwhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          shadows: AppConstants.kShadows,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: TextFormField(
                                              readOnly: true,
                                              // controller: nameController,
                                              decoration: InputDecoration(
                                                hintText: clientName,
                                                hintStyle: AppConstants
                                                    .kTextStyleSmallBoldGrey,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  //Staff Name
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shift Manager',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
                                        // height: MediaQuery.of(context).size.height / 16,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        decoration: ShapeDecoration(
                                          color: AppConstants.kcwhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          shadows: AppConstants.kShadows,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: TextFormField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: shiftManagerName,
                                                hintStyle: AppConstants
                                                    .kTextStyleSmallBoldGrey,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  //Time
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        decoration: ShapeDecoration(
                                          color: AppConstants.kcwhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          shadows: AppConstants.kShadows,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: Consumer<
                                                selectDateTimeForIncidentProvider>(
                                              builder: (context, dateTimeModel,
                                                  child) {
                                                String formattedTime =
                                                _formatTime(dateTimeModel
                                                    .selectedDateTime);

                                                return TextField(
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintText: dateTimeModel
                                                        .selectedDateTime
                                                        .year
                                                        .toString() +
                                                        '-' +
                                                        dateTimeModel
                                                            .selectedDateTime
                                                            .month
                                                            .toString() +
                                                        '-' +
                                                        dateTimeModel
                                                            .selectedDateTime
                                                            .day
                                                            .toString() +
                                                        ' ' +
                                                        formattedTime,
                                                    hintStyle: AppConstants
                                                        .kTextStyleSmallBoldGrey,
                                                    border: InputBorder.none,
                                                  ),
                                                  onTap: () async {
                                                    DateTime? picked =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate: dateTimeModel
                                                          .selectedDateTime,
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101),
                                                    );

                                                    if (picked != null) {
                                                      TimeOfDay? time =
                                                      await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                            dateTimeModel
                                                                .selectedDateTime),
                                                      );

                                                      if (time != null) {
                                                        DateTime
                                                        selectedDateTime =
                                                        DateTime(
                                                          picked.year,
                                                          picked.month,
                                                          picked.day,
                                                          time.hour,
                                                          time.minute,
                                                        );

                                                        dateTimeModel
                                                            .setSelectedDateTime(
                                                            selectedDateTime);
                                                      }
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  //Staff Designation
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Staff Designation',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        decoration: ShapeDecoration(
                                          color: AppConstants.kcwhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          shadows: AppConstants.kShadows,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText:
                                                shiftManagerDesignation,
                                                hintStyle: AppConstants
                                                    .kTextStyleSmallBoldGrey,
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
                                  //Location
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Location',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        decoration: ShapeDecoration(
                                          color: AppConstants.kcwhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          shadows: AppConstants.kShadows,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: TextFormField(
                                              // controller: nameController,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: location,
                                                hintStyle: AppConstants
                                                    .kTextStyleSmallBoldGrey,
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
                                ],
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  //Incident Type
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        child: Center(
                                          child: IncidentTypeDropdownWidget(),
                                        ),
                                      )
                                    ],
                                  ),
                                  //Action Taken By Staff
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            2.5,
                                        child: Center(
                                          child:
                                          ActionTakenByStaffDropdownWidget(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style:
                                    AppConstants.kTextStyleMediumBoldGrey,
                                  ),
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height / 12,
                                    decoration: ShapeDecoration(
                                      color: AppConstants.kcwhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      shadows: AppConstants.kShadows,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TextFormField(
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                          hintText: "Enter Hours",
                                          hintStyle: AppConstants
                                              .kTextStyleSmallBoldGrey,
                                          border: InputBorder.none,
                                          //  prefixIcon: Icon(
                                          //    Icons.person,
                                          //  ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                          selectedImagePath == null
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upload File',
                                style:
                                AppConstants.kTextStyleMediumBoldGrey,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.vertical(
                                              top: Radius.circular(
                                                  25))),
                                      context: context,
                                      builder: (context) => Container(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height /
                                            7,
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 80),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  IconButton(
                                                      onPressed:
                                                          () async {
                                                        // Navigator.pop(
                                                        //     context);
                                                        await _pickImage(
                                                            ImageSource
                                                                .camera);
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .camera_alt,
                                                        color: AppConstants
                                                            .kcprimaryColor,
                                                      )),
                                                  Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        color: AppConstants
                                                            .kcprimaryColor,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  IconButton(
                                                      onPressed:
                                                          () async {
                                                        Navigator.pop(
                                                            context);
                                                        await _pickImage(
                                                            ImageSource
                                                                .gallery);
                                                      },
                                                      icon: Icon(
                                                        Icons.photo,
                                                        color: AppConstants
                                                            .kcprimaryColor,
                                                      )),
                                                  Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        color: AppConstants
                                                            .kcprimaryColor,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                child: Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.50,
                                          color: Color(0xFF334155)),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 3.27,
                                            left: 1.75,
                                            right: 1.75,
                                            bottom: 2.54,
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons
                                                  .cloud_upload_outlined)
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(height: 16),
                                        Divider(
                                          color: Colors.transparent,
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Format PNG, JPG',
                                                textAlign:
                                                TextAlign.center,
                                                style: AppConstants
                                                    .kTextStyleSmallBoldGrey,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(
                                                  'Browse files',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                    Color(0xFF1051F8),
                                                    fontSize: 10,
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    height: 1.35,
                                                    letterSpacing: 0.30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                              : GestureDetector(
                            onTap: () async {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25))),
                                  context: context,
                                  builder: (context) => Container(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height /
                                        10,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              IconButton(
                                                  onPressed:
                                                      () async {
                                                    Navigator.pop(
                                                        context);
                                                    // _pickImage(
                                                    //     ImageSource.camera);
                                                    await _pickImage(
                                                        ImageSource
                                                            .camera);
                                                  },
                                                  icon: Icon(
                                                    Icons.camera_alt,
                                                    color: AppConstants
                                                        .kcprimaryColor,
                                                  )),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color: AppConstants
                                                        .kcprimaryColor,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              IconButton(
                                                  onPressed:
                                                      () async {
                                                    Navigator.pop(
                                                        context);
                                                    // _pickImage(ImageSource
                                                    //     .gallery);
                                                    await _pickImage(
                                                        ImageSource
                                                            .gallery);
                                                  },
                                                  icon: Icon(
                                                    Icons.photo,
                                                    color: AppConstants
                                                        .kcprimaryColor,
                                                  )),
                                              Text(
                                                "Gallery",
                                                style: TextStyle(
                                                    color: AppConstants
                                                        .kcprimaryColor,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Container(
                              child: Center(
                                  child: Image.file(
                                    File(selectedImagePath).absolute,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Builder(
                                builder: (context) =>
                                    Consumer<IncidentReportProvider>(
                                        builder: (context, provider, child) {
                                          return provider.isLoading
                                              ? Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(13),
                                                child: CircularProgressIndicator(),
                                              ))
                                              : ReuseableGradientButton(
                                              title: 'Submit',
                                              onpress: () async {
                                                if (selectIncidentTypeProvider
                                                    .type.isEmpty ||
                                                    selectIncidentTypeProvider
                                                        .type ==
                                                        'Select') {
                                                  Utils.showFlushbar(
                                                      'Please select incident type.',
                                                      context);
                                                } else if (actionTakenByStaffProvider
                                                    .type.isEmpty ||
                                                    actionTakenByStaffProvider
                                                        .type ==
                                                        'Select') {
                                                  Utils.showFlushbar(
                                                      'Please select action which was taken.',
                                                      context);
                                                } else if (descriptionController
                                                    .text.isEmpty) {
                                                  Utils.showFlushbar(
                                                      'Please explain what happened in decription box.',
                                                      context);
                                                } else if (selectedImagePath ==
                                                    null) {
                                                  Utils.showFlushbar(
                                                      'Please insert image of the incident.',
                                                      context);
                                                } else {
                                                  await incidentReportProvider
                                                      .submitIncidentReport(
                                                      jobId: JobId ?? '',
                                                      clientName:
                                                      clientName ?? '',
                                                      shiftManagerName:
                                                      shiftManagerName ??
                                                          '',
                                                      selectedDateTime:
                                                      time.selectedDateTime,
                                                      staffDesignation:
                                                      shiftManagerDesignation ??
                                                          '',
                                                      location: location ?? '',
                                                      incidentType:
                                                      selectIncidentTypeProvider
                                                          .type,
                                                      actionTakenByStaff:
                                                      actionTakenByStaffProvider
                                                          .type,
                                                      description:
                                                      descriptionController
                                                          .text,
                                                      imagePath:
                                                      selectedImagePath
                                                          .toString());
                                                  // Show the result dialog after the submission is complete
                                                  _showResultDialog(
                                                      context,
                                                      incidentReportProvider
                                                          .incidentReportFuture);
                                                }
                                              });
                                        }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          case Status.ERROR:
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height /
                    1.2, // Adjust the height as needed
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      assignedJobsProvider.apiResponse.message ?? 'Error',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );

          default:
            return Container();
        }
      }),
    );
  }

  // Manually format the time with AM/PM
  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    String minute =
    dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute $period';
  }

  // --- NEW METHOD TO CLEAR ALL DATA ---
  void _clearAllData() {
    // 1. Clear Text Controller
    descriptionController.clear();

    // 2. Clear Providers (Image & Dropdowns)
    final imageProvider =
    Provider.of<IncidentImageProviderClass>(context, listen: false);
    imageProvider.setIncidentImagePath(null);

    final incidentTypeProvider =
    Provider.of<SelectIncidentTypeProvider>(context, listen: false);
    final actionProvider =
    Provider.of<ActionTakenByStaffProvider>(context, listen: false);

    // IMPORTANT: Since 'type' variable does not have a setter, please find the method
    // in your provider class that sets the type. It is likely named setType() or resetType().
    // If you cannot find it, create a method inside SelectIncidentTypeProvider:
    // void reset() { _type = 'Select'; notifyListeners(); }

    // Uncomment the lines below and replace 'methodName' with the actual method name:
    // incidentTypeProvider.methodName('Select'); // <--- CHANGE THIS
    // actionProvider.methodName('Select');     // <--- CHANGE THIS

    // 3. Clear Local State Variables
    setState(() {
      JobId = null;
      clientName = null;
      shiftManagerName = null;
      shiftManagerDesignation = null;
      location = null;
      isSelected = false; // Reset so dialog pops up again next time
    });
  }
  // ------------------------------------

  void _showResultDialog(
      BuildContext context, Future<Map<String, dynamic>> future) {
    final currentTabProvider =
    Provider.of<BottomNavigationBarProvider>(context,listen: false);
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

                      // --- ADDED CLEAR DATA CALL ---
                      if (success) {
                        _clearAllData();
                      }
                      // ---------------------------

                      currentTabProvider.setCurrentScreen(JobHomeScreen());
                      currentTabProvider.setCurrentTab(2);
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

  // --- UPDATED METHOD WITH BUILT-IN COMPRESSION ---
  Future<void> _pickImage(ImageSource source) async {
    final status = await _requestPermission(source);
    if (status == PermissionStatus.granted) {

      // Image built-in compression
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 60,
        maxWidth: 1920,
      );

      if (pickedFile != null) {
        final imageProvider =
        Provider.of<IncidentImageProviderClass>(context, listen: false);
        imageProvider.setIncidentImagePath(pickedFile.path);
      }

    } else {
      Utils.showFlushbar(
          '${_getPermissionName(source)} permission not granted', context);
      // Permission not granted, handle accordingly
      print('${_getPermissionName(source)} permission not granted');
    }
  }
  // ---------------------------------------

  Future<PermissionStatus> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request();
    } else {
      return await Permission.storage.request();
    }
  }

  String _getPermissionName(ImageSource source) {
    return (source == ImageSource.camera) ? 'Camera' : 'Storage';
  }
  void showListOfAllJobsDialog(BuildContext context, List<Job> items) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('List of Current Jobs'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index].title ?? "No Title"),

                  // ✅ CLIENT NAME FIXED
                  subtitle: Text(
                    items[index].client != null
                        ? "${items[index].client!.firstName} ${items[index].client!.lastName}".trim()
                        : 'No client available',
                  ),

                  onTap: () {
                    setState(() {
                      JobId = items[index].id;

                      // CLIENT NAME FIXED
                      clientName = items[index].client != null
                          ? "${items[index].client!.firstName} ${items[index].client!.lastName}".trim()
                          : 'No client available';

                      // MANAGER NAME FIXED
                      shiftManagerName = (items[index].manager != null && items[index].manager!.isNotEmpty)
                          ? items[index].manager![0].name
                          : 'No manager available';

                      // MANAGER DESIGNATION FIXED
                      shiftManagerDesignation = (items[index].manager != null && items[index].manager!.isNotEmpty)
                          ? items[index].manager![0].phone
                          : 'No phone available';

                      // LOCATION FIXED
                      location = items[index].address != null
                          ? items[index].address!.formattedAddress
                          : "No Address";

                      Navigator.pop(context);
                    });
                  },

                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}