import 'dart:io';
import 'package:divine_employee_app/api_provider/claim_extra_api_provider.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/auth/presentation/screens/app_dashboard.dart';
import 'package:divine_employee_app/view/jobs/presentation/widgets/calculate_hours_widget.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../main.dart';

class GenerateJobReportScreen extends StatefulWidget {
  final String jobTitle;
  final String jobId;

  GenerateJobReportScreen(
      {super.key, required this.jobId, required this.jobTitle});

  @override
  State<GenerateJobReportScreen> createState() =>
      _GenerateJobReportScreenState();
}

class _GenerateJobReportScreenState extends State<GenerateJobReportScreen> {
  final TextEditingController shiftNotesController = TextEditingController();

  final TextEditingController distanceTravelledController =
      TextEditingController();

  final TextEditingController extraAmountController = TextEditingController();

  final TextEditingController extraHoursController = TextEditingController();

  bool wantToClaim = false;

  @override
  Widget build(BuildContext context) {
    final claimExtraApiProvider = Provider.of<ClaimExtraApiProvider>(context);
    // final timerModel = Provider.of<TimerModel>(context);
    final claimExtraImageProvider =
        Provider.of<ClaimExtraImageProviderClass>(context);
    final selectedImagePath = claimExtraImageProvider.claimExtraImagePath;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppConstants.kcprimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: AppConstants.kcwhiteColor,
        ),
        forceMaterialTransparency: true,
        // backgroundColor: AppConstants.kcprimaryColor,

        elevation: 0.0,
        title: Text('Submit Job Report',
            style: AppConstants.kTextStyleLargreBoldWhite),
        centerTitle: true,
      ),

      // appBarTitle: 'End Task Detials',
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppConstants.kcgreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(46.0),
            topRight: Radius.circular(46.0),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode focusScopeNode = FocusScope.of(context);
            if (!focusScopeNode.hasPrimaryFocus) {
              focusScopeNode.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CalculateHoursWidget(),
                Divider(
                  color: Colors.transparent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.jobTitle,
                              style: AppConstants
                                  .kTextStyleSmallRegularBlackDecription,
                            ),
                          ),
                        ],
                      ),
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
                            style: AppConstants
                                .kTextStyleSmallRegularBlackDecription,
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
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor:
                        Colors.transparent, // Color of the divider lines
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    backgroundColor: Colors.transparent,
                    childrenPadding: EdgeInsets.all(8.0), // Add padding here
                    onExpansionChanged: (value) {
                      setState(() {
                        wantToClaim = !wantToClaim;
                      });
                    },
                    iconColor: AppConstants.kcprimaryColor,
                    collapsedIconColor: Colors.red,
                    title: RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Claim Extra Hours or Distance Traveled ? ',
                          style: AppConstants.kTextStyleMediumBoldGrey,
                        ),
                        TextSpan(
                          text: wantToClaim ? 'Yes' : 'No',
                          style: wantToClaim
                              ? AppConstants.kTextStyleSmallBoldprimary
                              : AppConstants.kTextStyleSmallBoldprimary
                                  .copyWith(color: Colors.red),
                        ),
                      ],
                    )),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Out of pocket expense
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Out of Pocket Expense ',
                                style: AppConstants.kTextStyleMediumBoldGrey,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 3,
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
                                      keyboardType: TextInputType.number,
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackDecription,
                                      controller: extraAmountController,
                                      decoration: InputDecoration(
                                        hintText: "Enter Amount (\$)",
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
                          //Distance Travelled
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Distance Travelled ',
                                style: AppConstants.kTextStyleMediumBoldGrey,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 3,
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
                                      keyboardType: TextInputType.number,
                                      controller: distanceTravelledController,
                                      style: AppConstants
                                          .kTextStyleSmallRegularBlackDecription,
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
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Upload File
                          selectedImagePath == null
                              ? GestureDetector(
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
                                                  6,
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
                                                              // getImageFromCamera();
                                                              _pickImage(
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
                                                              _pickImage(
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Upload File',
                                        style: AppConstants
                                            .kTextStyleMediumBoldGrey,
                                      ),
                                      Container(
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
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // width: 28,
                                                // height: 28,
                                                padding: const EdgeInsets.only(
                                                  top: 4.27,
                                                  left: 1.75,
                                                  right: 1.75,
                                                  bottom: 3.54,
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
                                                      'Format DOC, PDF, JPG',
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
                                    ],
                                  ),
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
                                                              // getImageFromCamera();
                                                              _pickImage(
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
                                                              _pickImage(
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

                          //Extra
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Extra Hours',
                                style: AppConstants.kTextStyleMediumBoldGrey,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 3,
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
                                      keyboardType: TextInputType.number,
                                      controller: extraHoursController,
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
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.transparent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Builder(
                      builder: (context) => Consumer<ClaimExtraApiProvider>(
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
                                  var result = await claimExtraApiProvider
                                      .submitIncidentReport(
                                    jobId: widget.jobId,
                                    jobNotes: shiftNotesController.text,
                                    outofpocket: extraAmountController.text,
                                    extradistance:
                                        distanceTravelledController.text,
                                    extrahours: extraHoursController.text,
                                    imagePath: selectedImagePath != null
                                        ? selectedImagePath.toString()
                                        : null,
                                  );
                                  // Show the result dialog after the submission is complete
                                  _showResultDialog(context,
                                      claimExtraApiProvider.claimExtraFuture);
                                  bool success = result['success'] ?? false;
                                  if (success) {
                                    // timerModel.resetTimer();
                                  }
                                  // _showCustomAlertDialog(context);
                                },
                              );
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final imageProvider =
          Provider.of<ClaimExtraImageProviderClass>(context, listen: false);
      imageProvider.setClaimImagePath(pickedFile.path);
    }
  }
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
            print(":::error messae in the alertdialouge box: ${message}");
            return AlertDialog(
              title: Text(success ? 'Success' : 'Error'),
              content: Text(success
                  ? "You\'ve successfully Completed your Job."
                  : message),
              actions: <Widget>[
                ReuseableGradientButton(
                  onpress: () {
                    if (success) {
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
                          context, SlideTransitionPage(page: AppDashboard()));
                    } else {
                      Navigator.pop(context);
                    }
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
