import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/profile/provider/edit_image_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../../../../core/common widgets/reuseable_gradient_small_button.dart';
import '../../../../api_provider/data_provider_for_employee_profile.dart';
import '../../../../api_provider/profile_update_api_provider.dart';
import '../widgets/profile_picture_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameEditingController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with data from the provider
    final employeeData =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    _nameEditingController = TextEditingController(
        text: employeeData.employeeProfile?.employee.name ?? '');
    _phoneController = TextEditingController(
        text: employeeData.employeeProfile?.employee.phone ?? '');
    _passwordController = TextEditingController();
  }

  Future<void> _pickImage(ImageSource source) async {
    final status = await _requestPermission(source);
    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final imageProvider =
            Provider.of<ProfileImageProviderClass>(context, listen: false);
        imageProvider.setProfileImagePath(pickedFile.path);
      }
    } else {
      Utils.showFlushbar(
          '${_getPermissionName(source)} permission not granted', context);
      // Permission not granted, handle accordingly
      if (kDebugMode)
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

  @override
  Widget build(BuildContext context) {
    final profileImageProvider =
        Provider.of<ProfileImageProviderClass>(context);

    return Scaffold(
      backgroundColor: AppConstants.kcprimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppConstants.kcwhiteColor,
        ),
        forceMaterialTransparency: true,
        // backgroundColor: AppConstants.kcprimaryColor,

        elevation: 0.0,
        title:
            Text('Edit Profile', style: AppConstants.kTextStyleLargreBoldWhite),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: AppConstants.kgradientScreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          // EditProfileDetailsWidget(),
          Container(
            margin: EdgeInsets.only(top: 80),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: AppConstants.kcgreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(29),
                    topRight: Radius.circular(29))),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 13,
                  ),

                  // Edit  button
                  ReuseableGradientSmallButton(
                    title: 'Edit Image',
                    onpress: () async {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25))),
                          context: context,
                          builder: (context) => Container(
                                height: MediaQuery.of(context).size.height /5,
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
                                                // Check if the camera permission is already granted
                                                var status = await Permission
                                                    .camera.status;

                                                if (status.isDenied) {
                                                  // If permission is denied, request it
                                                  var result = await Permission
                                                      .camera
                                                      .request();
                                                  if (result.isGranted) {
                                                    // Permission granted, you can now use the camera
                                                    print(
                                                        'Camera permission granted');
                                                    Navigator.pop(context);
                                                    _pickImage(
                                                        ImageSource.camera);
                                                  } else {
                                                    // Permission denied, handle it accordingly (show an explanation, disable features, etc.)
                                                    print(
                                                        'Camera permission denied');
                                                  }
                                                } else {
                                                  // Permission already granted
                                                  print(
                                                      'Camera permission already granted');
                                                  Navigator.pop(context);
                                                  _pickImage(
                                                      ImageSource.camera);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color:
                                                    AppConstants.kcprimaryColor,
                                              )),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                color:
                                                    AppConstants.kcprimaryColor,
                                                fontWeight: FontWeight.bold),
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
                                              // Check if the storage (read/write external storage) permission is already granted
                                              var status = await Permission
                                                  .storage.status;

                                              if (status.isDenied) {
                                                // If permission is denied, request it
                                                var result = await Permission
                                                    .storage
                                                    .request();
                                                if (result.isGranted) {
                                                  // Permission granted, you can now use the photo library
                                                  print(
                                                      'Storage permission granted');
                                                  Navigator.pop(context);
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                } else {
                                                  // Permission denied, handle it accordingly (show an explanation, disable features, etc.)
                                                  print(
                                                      'Storage permission denied');
                                                }
                                              } else {
                                                // Permission already granted
                                                print(
                                                    'Storage permission already granted');
                                                Navigator.pop(context);
                                                _pickImage(ImageSource.gallery);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.photo,
                                              color:
                                                  AppConstants.kcprimaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                              color:
                                                  AppConstants.kcprimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                  ),

                  // options
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: ShapeDecoration(
                        color: AppConstants.kcwhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Username',
                                        style: AppConstants
                                            .kTextStyleMediumBoldBlack),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 12, left: 12, right: 12),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: ShapeDecoration(
                                        // color: AppConstants.kcwhiteColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFA8A8A8)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _nameEditingController,
                                          decoration: InputDecoration(
                                            hintText: "Your Name",
                                            contentPadding: EdgeInsets.all(8),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Phone Number',
                                        style: AppConstants
                                            .kTextStyleMediumBoldBlack),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 12, left: 12, right: 12),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: ShapeDecoration(
                                        // color: AppConstants.kcwhiteColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFA8A8A8)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _phoneController,
                                          decoration: InputDecoration(
                                            hintText: "+61 234 578 879",
                                            contentPadding: EdgeInsets.all(8),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Text('Password',
                                        style: AppConstants
                                            .kTextStyleMediumBoldBlack),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 26, left: 16, right: 16),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: ShapeDecoration(
                                        // color: AppConstants.kcwhiteColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFA8A8A8)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "••••••••",
                                              // hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(8)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Consumer<ProfileUpdateApiProvider>(
                                    builder: (context, provider, child) {
                                      return provider.isLoading
                                          ? Center(
                                              child: Padding(
                                              padding: const EdgeInsets.all(13),
                                              child:
                                                  CircularProgressIndicator(),
                                            ))
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 48,
                                                  bottom: 12,
                                                  left: 48.0),
                                              child: ReuseableGradientButton(
                                                onpress: () async {
                                                  if (!provider.isLoading) {
                                                    // Show loading indicator
                                                    provider.isLoading = true;
                                                    try {
                                                      Map<String, dynamic>
                                                          response =
                                                          await provider.updateProfilee(
                                                              name:
                                                                  _nameEditingController
                                                                      .text,
                                                              phone:
                                                                  _phoneController
                                                                      .text,
                                                              password:
                                                                  _passwordController
                                                                      .text,
                                                              imagePath:
                                                                  profileImageProvider
                                                                      .ProfileImagePath
                                                              // .toString()
                                                              // .trim(),
                                                              );

                                                      if (response['success'] ==
                                                          true) {
                                                        print(
                                                            'Profile Updated successfully');
                                                        // EmployeeProfileApiProvider()
                                                        //     .fetchEmployeeProfileAndNotify(
                                                        //         context);
                                                        Provider.of<DataProviderForEmployeeProfile>(
                                                                context,
                                                                listen: false)
                                                            .fetchEmployeeProfile();

                                                        _showResultDialog(
                                                            context,
                                                            message:
                                                                'Profile Updated  successfully');
                                                      } else {
                                                        print(
                                                            'Error Profile Updated : ${response['message']}');
                                                        Utils.showFlushbar(
                                                            response['message'],
                                                            context);
                                                      }
                                                    } catch (e) {
                                                      // Handle error, you can show an error dialog here
                                                      print(
                                                          'Error updating profile: $e');
                                                    } finally {
                                                      // Hide loading indicator
                                                      provider.isLoading =
                                                          false;
                                                    }
                                                  }
                                                },
                                                title: 'Update',
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          ProfilePictureWidget()
        ],
      ),
    );
  }

  void _showResultDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
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
      },
    );
  }
}
