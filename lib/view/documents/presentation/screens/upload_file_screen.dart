import 'package:divine_employee_app/api_provider/upload_doc_api_provider.dart';
import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common widgets/reuseable_gradient_button.dart';
import '../provider/expiry_date_provider.dart';

class UploadFileScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TabController? parentTabController;
  final ScrollController _scrollController = ScrollController();

  UploadFileScreen({super.key, required this.parentTabController});

  @override
  Widget build(BuildContext context) {
    final uploadDocumentApiProvider =
        Provider.of<UploadDocumentApiProvider>(context);
    final expiryDateProvider = Provider.of<ExpiryDateProvider>(context);
    final selectedDocumentPathProvider = Provider.of<SelectedPDFPath>(context);
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Container(
              padding: EdgeInsets.all(8),
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
                    'Upload Document',
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    'Document Title',
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
                        side: BorderSide(width: 1, color: Color(0xFF334155)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter Document Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    'Document Details',
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 12,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF334155)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: TextFormField(
                      maxLines: 2,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter Document Detials",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // document details
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    'Document Expiry Date',
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.height / 17,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF334155)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Consumer<ExpiryDateProvider>(
                        builder: (context, dateProvider, _) {
                          return Text(
                            '${dateProvider.selectedDate.toLocal()}'
                                .split(' ')[0],
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  //uplaod file
                  Text(
                    'Upload File',
                    style: AppConstants.kTextStyleMediumBoldBlack,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),

                  Consumer<SelectedPDFPath>(
                      builder: (context, selectedPDFPath, _) {
                    return GestureDetector(
                      onTap: () {
                        pickPDF(context);
                      },
                      child: Stack(
                        children: [
                          if (selectedPDFPath.path.isNotEmpty)
                            Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  // color: AppConstants.kcprimaryColor,
                                )),
                          Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFF334155)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  selectedPDFPath.path.isNotEmpty
                                      ? Column(
                                          children: [
                                            Icon(Icons.picture_as_pdf,
                                                color: AppConstants
                                                    .kcprimaryColor,
                                                size: 50),
                                            Text(
                                              selectedPDFPath.path
                                                  .split('/')
                                                  .last,
                                              style: AppConstants
                                                  .kTextStyleSmallRegularBlack,
                                            ),
                                          ],
                                        )
                                      : Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.only(
                                                  top: 3.27,
                                                  left: 1.75,
                                                  right: 1.75,
                                                  bottom: 2.54,
                                                ),
                                                clipBehavior:
                                                    Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    Icon(Icons
                                                        .cloud_upload_outlined)
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.transparent,
                                              ),
                                              Text(
                                                'Format DOC, PDF, JPG',
                                                textAlign: TextAlign.center,
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
                    );
                  }),

                  Divider(
                    color: Colors.transparent,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),

                  Builder(
                    builder: (context) => Consumer<UploadDocumentApiProvider>(
                        builder: (context, provider, child) {
                      return provider.isLoading
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ))
                          : ReuseableGradientButton(
                              title: 'Upload File',
                              onpress: () async {
                                if (titleController.text.isEmpty) {
                                  Utils.showFlushbar(
                                      'Please Enter title', context);
                                } else if (descriptionController.text.isEmpty) {
                                  Utils.showFlushbar(
                                      'Please Enter details', context);
                                } else if (selectedDocumentPathProvider
                                        .path.isEmpty ||
                                    selectedDocumentPathProvider.path == '') {
                                  Utils.showFlushbar(
                                      'Please selectDocument', context);
                                } else {
                                  await uploadDocumentApiProvider
                                      .UploadDocument(
                                          context: context,
                                          documentTitle: titleController.text,
                                          documentDetails:
                                              descriptionController.text,
                                          documentExiprydate:
                                              expiryDateProvider.selectedDate,
                                          documentPath:
                                              selectedDocumentPathProvider
                                                  .path);
                                  _showResultDialog(
                                      context,
                                      uploadDocumentApiProvider
                                          .uplaodDocumentFuture);
                                }
                              });
                    }),
                  ),
                ],
              ))),
    );
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
                title: Text(success ?  'Success' : 'Error'),
                content: Text(message),
                actions: <Widget>[
                  ReuseableGradientButton(
                    onpress: () {
                      Navigator.of(context).pop();
                      // Use the static method to trigger tab change
                      parentTabController?.animateTo(1);
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

  Future<void> pickPDF(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        print('Picked PDF file path: $filePath');

        // Update the selected PDF path using the provider
        Provider.of<SelectedPDFPath>(context, listen: false).setPath(filePath);
      } else {
        print('User canceled the file picker');
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final ExpiryDateProvider dateProvider =
        Provider.of<ExpiryDateProvider>(context, listen: false);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != dateProvider.selectedDate) {
      dateProvider.setSelectedDate(picked);
    }
  }
}

class SelectedPDFPath extends ChangeNotifier {
  String _path = '';

  String get path => _path;

  void setPath(String newPath) {
    _path = newPath;
    notifyListeners();
  }
}
