import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_small_button.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/models/get_invoice_model.dart';
import 'package:divine_employee_app/view/earnings/presentation/widgets/header_of_invoice_widget.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceDetilasScreen extends StatefulWidget {
  final EmployeeInvoic employeeInvoic;

  InvoiceDetilasScreen({
    Key? key,
    required this.employeeInvoic,
  }) : super(key: key);

  @override
  State<InvoiceDetilasScreen> createState() => _InvoiceDetilasScreenState();
}

class _InvoiceDetilasScreenState extends State<InvoiceDetilasScreen> {
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final employeeEarnings =
        Provider.of<DataProviderForEmployeeProfile>(context, listen: false);
    final earnings = employeeEarnings.employeeProfile;
    var employeeName = earnings!.employee.name;
    // var employeeImage = earnings.employee.imageUrl;
    var employeeEmail = earnings.employee.email;
    var employeePhone = earnings.employee.phone;
    var employeeId = earnings.employee.id;

    String lastFourCharacters = employeeId.substring(employeeId.length - 4);
    String restOfTheString = employeeId.substring(0, employeeId.length - 4);

    print("Last four characters of the employee ID: $lastFourCharacters");
    print("Rest of the employee ID: $restOfTheString");
    return ReuseableScaffoldScreen(
      appBarTitle: 'Details',
      content: Stack(
        children: [
          Column(
            children: [
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.60, color: Color(0xFFEBEFF6)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      HeaderOfInvoiceWidget(
                        isPaid: widget.employeeInvoic.status == 'paid'
                            ? true
                            : false,
                        startDate: widget.employeeInvoic.fromDate,
                        endDate: widget.employeeInvoic.toDate,
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      'Pay To:',
                                      style: AppConstants
                                          .kTextStyleMediumBoldBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        employeeName,
                                        style: AppConstants
                                            .kTextStyleMediumBoldBlack,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Employee Id:',
                                            style: AppConstants
                                                .kTextStyleMediumBoldGrey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            lastFourCharacters,
                                            style: AppConstants
                                                .kTextStyleSmallBoldBlack,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone No:',
                                            style: AppConstants
                                                .kTextStyleMediumBoldGrey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            employeePhone,
                                            style: AppConstants
                                                .kTextStyleSmallBoldBlack,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Email:',
                                            style: AppConstants
                                                .kTextStyleMediumBoldGrey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            employeeEmail,
                                            style: AppConstants
                                                .kTextStyleSmallBoldBlack,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.info),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      'Details:',
                                      style: AppConstants
                                          .kTextStyleMediumBoldBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gross Pay:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.employeeInvoic.grosspay
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Net Pay:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.employeeInvoic.netpay
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Amount Details:',
                                style: AppConstants.kTextStyleMediumBoldBlack,
                              ),
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.totalPayment.toString(),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Allowances:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.allowances
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Extra Amount:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.extraAmount.toString(),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gross Pay:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.grosspay
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax Free Trash Hold:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.taxFreeTrashHold
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fortnightly Tax:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.fortnightlyTax
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medical Leavy Tax:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.medicalLeaveyTax
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                            Divider(
                              color: AppConstants.kcgreyColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Net Pay:',
                                  style: AppConstants.kTextStyleMediumBoldGrey,
                                ),
                                Text(
                                  widget.employeeInvoic.netpay
                                      .toStringAsFixed(2),
                                  style: AppConstants.kTextStyleSmallBoldBlack,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 20,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      ReuseableSmallButton(
                          onpress: () {
                            _captureAndShare();
                          },
                          text: 'Print',
                          bgColor: AppConstants.kcgreenbgColor,
                          textStyle: AppConstants.kTextStyleSmallBoldGreen)
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndShare() async {
    try {
      // Capture the screenshot
      Uint8List? image = await _screenshotController.capture(
          delay: const Duration(milliseconds: 10));

      if (image != null) {
        // Get the application documents directory
        final directory = await getApplicationDocumentsDirectory();

        // Create a file to store the captured image
        final imagePath = await File('${directory.path}/image.png').create();

        // Write the image bytes to the file
        await imagePath.writeAsBytes(image);

        // Share the captured image using the Share plugin
        // ignore: deprecated_member_use
        await Share.shareFiles([imagePath.path]);
      }
    } catch (error) {
      print(error);
    }
  }
}
