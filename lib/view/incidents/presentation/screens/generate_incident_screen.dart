import 'dart:io';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/incidents/presentation/provider/select_date_time_provider_for_incident.dart';
import 'package:divine_employee_app/view/incidents/presentation/provider/select_incident_provider.dart';
import 'package:divine_employee_app/view/incidents/presentation/widgets/action_taken_by_staff_drop_down_widget.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../api_provider/incident_report_provider.dart';
import '../widgets/incident_type_drop_down_widget.dart';

class GenerateIncidentScreen extends StatefulWidget {
  final String JobId;
  final String clientName;
  final String shiftManagerName;
  final String shiftManagerDesignation;
  final String location;

  const GenerateIncidentScreen(
      {super.key,
      required this.JobId,
      required this.clientName,
      required this.shiftManagerName,
      required this.shiftManagerDesignation,
      required this.location});

  @override
  State<GenerateIncidentScreen> createState() => _GenerateIncidentScreenState();
}

class _GenerateIncidentScreenState extends State<GenerateIncidentScreen> {
  var timeNow = DateTime.now();
  final TextEditingController incidentController = TextEditingController();
  final TextEditingController actionTakenbyStaffController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      content: GestureDetector(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Shift Id
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Job Id',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  // height: MediaQuery.of(context).size.height / 16,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        // controller: nameController,
                                        decoration: InputDecoration(
                                          hintText: widget.JobId,
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
                            //Client Name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Client Name',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        // controller: nameController,
                                        decoration: InputDecoration(
                                          hintText: widget.clientName,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Staff Name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shift Manager',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  // height: MediaQuery.of(context).size.height / 16,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: widget.shiftManagerName,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: Consumer<
                                          selectDateTimeForIncidentProvider>(
                                        builder:
                                            (context, dateTimeModel, child) {
                                          String formattedTime = _formatTime(
                                              dateTimeModel.selectedDateTime);

                                          return TextField(
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              // hintText: dateTimeModel
                                              //     .selectedDateTime
                                              //     .toString(),
                                              hintText: dateTimeModel
                                                      .selectedDateTime.year
                                                      .toString() +
                                                  '-' +
                                                  dateTimeModel
                                                      .selectedDateTime.month
                                                      .toString() +
                                                  '-' +
                                                  dateTimeModel
                                                      .selectedDateTime.day
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
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dateTimeModel
                                                              .selectedDateTime),
                                                );

                                                if (time != null) {
                                                  DateTime selectedDateTime =
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Staff Designation
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Staff Designation',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText:
                                              widget.shiftManagerDesignation,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                    child: Center(
                                      child: TextFormField(
                                        // controller: nameController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: widget.location,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Incident Type
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Center(
                                    child: IncidentTypeDropdownWidget(),
                                  ),
                                )
                              ],
                            ),
                            //Action Taken By Staff
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Center(
                                    child: ActionTakenByStaffDropdownWidget(),
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
                              style: AppConstants.kTextStyleMediumBoldGrey,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: ShapeDecoration(
                                color: AppConstants.kcwhiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadows: AppConstants.kShadows,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    hintText: "Please tell us what happened",
                                    hintStyle:
                                        AppConstants.kTextStyleSmallBoldGrey,
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
                                style: AppConstants.kTextStyleMediumBoldGrey,
                              ),
                              GestureDetector(
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
                                                          onPressed: () async {
                                                            // Navigator.pop(
                                                            //     context);
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
                                                          onPressed: () async {
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
                                      borderRadius: BorderRadius.circular(12),
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
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.cloud_upload_outlined)
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(height: 16),
                                        Divider(
                                          color: Colors.transparent,
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Format PNG, JPG',
                                                textAlign: TextAlign.center,
                                                style: AppConstants
                                                    .kTextStyleSmallBoldGrey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(
                                                  'Browse files',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF1051F8),
                                                    fontSize: 10,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 80),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        // _pickImage(
                                                        //     ImageSource.camera);
                                                        await _pickImage(
                                                            ImageSource.camera);
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
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
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
                                                            FontWeight.bold),
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
                                          selectIncidentTypeProvider.type ==
                                              'Select') {
                                        Utils.showFlushbar(
                                            'Please select incident type.',
                                            context);
                                      } else if (actionTakenByStaffProvider
                                              .type.isEmpty ||
                                          actionTakenByStaffProvider.type ==
                                              'Select') {
                                        Utils.showFlushbar(
                                            'Please select action which was taken.',
                                            context);
                                      } else if (descriptionController
                                          .text.isEmpty) {
                                        Utils.showFlushbar(
                                            'Please explain what happened in decription box.',
                                            context);
                                      }
                                      // else if (selectedImagePath == null) {
                                      //   Utils.showFlushbar(
                                      //       'Please insert image of the incident.',
                                      //       context);
                                      // }
                                      else {
                                        await incidentReportProvider
                                            .submitIncidentReport(
                                                jobId: widget.JobId,
                                                clientName: widget.clientName,
                                                shiftManagerName:
                                                    widget.shiftManagerName,
                                                selectedDateTime:
                                                    time.selectedDateTime,
                                                staffDesignation: widget
                                                    .shiftManagerDesignation,
                                                location: widget.location,
                                                incidentType:
                                                    selectIncidentTypeProvider
                                                        .type,
                                                actionTakenByStaff:
                                                    actionTakenByStaffProvider
                                                        .type,
                                                description:
                                                    descriptionController.text,
                                                imagePath: selectedImagePath
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
      ),
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

  Future<void> _pickImage(ImageSource source) async {
    final status = await _requestPermission(source);
    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(source: source);
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
}
