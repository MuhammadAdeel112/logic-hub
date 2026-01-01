import 'package:divine_employee_app/api_provider/registration_api_provider.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/registration/state/dob_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  ///General
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _drivingLiscnceController =
      TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
        resizeToAvoidBottomInset: true,
        notification_icon: false,
        appBarTitle: 'Apply For Registration',
        content: Container(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Divider(
                  color: Colors.transparent,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                        child: Text(
                          'Name',
                          style: AppConstants.kTextStyleMediumRegularBlack,
                        ),
                      ),
                      Container(
                        decoration:
                            AppConstants.KContainerStyleForTextFormField,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Jhon",
                                hintStyle: AppConstants.kTextStyleSmallBoldGrey,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                      child: Text(
                        'Email',
                        style: AppConstants.kTextStyleMediumRegularBlack,
                      ),
                    ),
                    Container(
                      decoration: AppConstants.KContainerStyleForTextFormField,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "example@gmail.com",
                              hintStyle: AppConstants.kTextStyleSmallBoldGrey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                          child: Text(
                            'Phone Number',
                            style: AppConstants.kTextStyleMediumRegularBlack,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration:
                              AppConstants.KContainerStyleForTextFormField,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextFormField(
                                inputFormatters: [],
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  hintText: "e.g. +61 33 333 333",
                                  hintStyle:
                                      AppConstants.kTextStyleSmallBoldGrey,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                          child: Text(
                            'Date of Birth',
                            style: AppConstants.kTextStyleMediumRegularBlack,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            selectDateOfBirth(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration:
                                AppConstants.KContainerStyleForTextFormField,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: Consumer<UserDateOfBirth>(
                                  builder: (BuildContext context,
                                      UserDateOfBirth userData, Widget? child) {
                                    return Text(
                                      userData.user.dateOfBirth == null
                                          ? 'Select Date of Birth'
                                          : formatDate(
                                              userData.user.dateOfBirth!),
                                    );
                                  },
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                      child: Text(
                        'Address',
                        style: AppConstants.kTextStyleMediumRegularBlack,
                      ),
                    ),
                    Container(
                      decoration: AppConstants.KContainerStyleForTextFormField,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              hintText: "e.g. Elderly Caregiver",
                              hintStyle: AppConstants.kTextStyleSmallBoldGrey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Staff Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                          child: Text(
                            'Driving License No',
                            style: AppConstants.kTextStyleMediumRegularBlack,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration:
                              AppConstants.KContainerStyleForTextFormField,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _drivingLiscnceController,
                                decoration: InputDecoration(
                                  hintText: "e.g. 001 33 333 333",
                                  hintStyle:
                                      AppConstants.kTextStyleSmallBoldGrey,
                                  border: InputBorder.none,
                                 
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                          child: Text(
                            'Password',
                            style: AppConstants.kTextStyleMediumRegularBlack,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration:
                              AppConstants.KContainerStyleForTextFormField,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: "e.g. **********",
                                  hintStyle:
                                      AppConstants.kTextStyleSmallBoldGrey,
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
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                      child: Consumer<RegistrationApiProvider>(
                        builder: (BuildContext context,
                            RegistrationApiProvider value, Widget? child) {
                          return value.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ReuseableGradientButton(
                                  title: 'Register',
                                  onpress: () {
                                    if ((_nameController.text.isEmpty ||
                                            _emailController.text.isEmpty) ||
                                        (_passwordController.text.isEmpty ||
                                            _addressController.text.isEmpty) ||
                                        (_drivingLiscnceController
                                                .text.isEmpty ||
                                            _passwordController.text.isEmpty)) {
                                      Utils.showFlushbar(
                                          "fill the required fields", context);
                                    } else {
                                      DateTime? dateOfBirth =
                                          Provider.of<UserDateOfBirth>(context,
                                                  listen: false)
                                              .user
                                              .dateOfBirth;

                                      value.createEmplyee(
                                        employeeName: _nameController.text,
                                        employeeEmail: _emailController.text,
                                        emplyeePhoneNumber:
                                            _phoneController.text,
                                        employeeDOB: dateOfBirth!,
                                        employeeAddress:
                                            _addressController.text,
                                        employeeLisenese:
                                            _drivingLiscnceController.text,
                                        employeePassword:
                                            _passwordController.text,
                                        context: context,
                                      );
                                      Utils.dismissKeyboard(context);
                                     
                                    }
                                  },
                                  width: MediaQuery.of(context).size.width / 4,
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
