import 'package:divine_employee_app/api_provider/clock_out_api_provider.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/timer_model.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/generate_job_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:divine_employee_app/api_provider/clock_in_api_provider.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_gradient_small_button.dart';
import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:divine_employee_app/core/utils/utlis.dart';
import 'package:divine_employee_app/view/jobs/presentation/screens/during_job_screen.dart';

// ignore: must_be_immutable
class ScanQrCode extends StatefulWidget {
  bool isClockIn;
  bool isClockOut;
  String cilentId;
  String JobId;

  var jobTitle;

  ScanQrCode({
    Key? key,
    this.isClockIn = false,
    this.isClockOut = false,
    required this.cilentId,
    required this.JobId,
    this.jobTitle,
  }) : super(key: key);

  @override
  _ScanQrCodeState createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  var provider;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // ✅ FIX 1: Changed from `late` to nullable — prevents LateInitializationError
  QRViewController? controller;

  late String scannedValue;
  String message = 'Scanning...';
  bool isSccaned = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  bool _manualInputMode = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ClockInApiProvider>(context);

    return ReuseableScaffoldScreen(
      appBarTitle: 'Scan Qr Code at Job',
      content: !_manualInputMode
          ? Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.transparent,
          ),
          provider.isLoading
              ? CircularProgressIndicator()
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReuseableGradientSmallButton(
                  title: 'Re-Scan',
                  onpress: () {
                    // ✅ FIX 2: Null-safe call + reset isSccaned flag
                    controller?.resumeCamera();
                    setState(() {
                      message = 'Scanning...';
                      scannedValue = '';
                      isSccaned = false;
                    });
                  }),
              ReuseableGradientSmallButton(
                onpress: () {
                  setState(() {
                    _manualInputMode = !_manualInputMode;
                  });
                },
                title: _manualInputMode
                    ? 'Switch to Scan'
                    : 'Enter Code Manually',
              ),
            ],
          ),
        ],
      )
          : _buildManualInputForm(),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // ✅ FIX 3: Guard against multiple triggers from same scan
      if (!isSccaned) {
        setState(() {
          isSccaned = true;
          scannedValue = scanData.code ?? '';
          _handleScannedValue(scannedValue);
        });
      }
    });
  }

  Widget _buildManualInputForm() {
    return _manualInputMode
        ? Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Enter Code Manually'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the full code';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReuseableGradientSmallButton(
                title: 'Submit',
                onpress: () {
                  if (_formKey.currentState!.validate()) {
                    // Clock-out jaisa simple logic: pura typed code direct compare
                    _handleScannedValue(_textEditingController.text.trim());
                  }
                },
              ),
              ReuseableGradientSmallButton(
                onpress: () {
                  setState(() {
                    _manualInputMode = !_manualInputMode;
                  });
                },
                title: _manualInputMode
                    ? 'Switch to Scan'
                    : 'Enter Code Manually',
              ),
            ],
          ),
        ],
      ),
    )
        : SizedBox();
  }

  void _handleScannedValue(String value) {
    if (value.isNotEmpty) {
      setState(() {
        if (value == widget.cilentId) {
          if (widget.isClockIn) {
            message = 'Scanned Successfully. Wait for Clock In';
          } else {
            message = 'Scanned Successfully. Wait for Clock Out';
          }
          // ✅ FIX 4: Use safe wrapper instead of direct call
          _pauseCameraSafely();
          if (widget.isClockIn == true) {
            clockIn(context);
          }
          if (widget.isClockOut == true) {
            clockout();
          }
        } else {
          // ✅ FIX 5: stopCamera() → pauseCamera() via safe wrapper (THIS was the crash cause)
          _pauseCameraSafely();
          message =
          'Scanned Failed. Re-Scan and if couldnot figure out please contact manager.';

          Utils.showFlushbar('Wrong Code. Try Again', context);
        }
      });
    } else {
      setState(() {
        message = 'Error: Unable to read QR Code. Please try again.';
      });
    }
  }

  // ✅ FIX 6: Safe camera pause — catches any native-side errors silently
  void _pauseCameraSafely() {
    try {
      controller?.pauseCamera();
    } catch (e) {
      debugPrint('Camera pause skipped: $e');
    }
  }

  clockIn(BuildContext context) async {
    if (!provider.isLoading) {
      try {
        provider.resetLoading();
        final result = await provider.submitClockInRequest(widget.JobId, context);

        if (result['success']) {
          final SharedPreferences sp = await SharedPreferences.getInstance();
          var i = await sp.setString('currentJobId', widget.JobId);
          print(' job id : ${i} which was stored in FFat clock in');
          print(' job id : ${widget.cilentId} which was set to at clock in');
          Provider.of<WorkProvider>(context, listen: false).clockIn();
          Navigator.push(
              context,
              SlideTransitionPage(
                page: DuringJobScreen(),
              ));
          Utils.showFlushbar('Clock-In request Successful', context);
        } else {
          Utils.showFlushbar(
              'Clock-In request failed: ${result['message']}', context);
          print('Clock-In request failed: ${result['message']}');
        }
      } finally {
        provider.resetLoading();
      }
    }
  }

  clockout() async {
    final provider = Provider.of<ClockOutApiProvider>(context, listen: false);
    if (!provider.isLoading) {
      try {
        final result = await provider.submitClockOutRequest(widget.JobId, context);

        if (result['success']) {
          Provider.of<WorkProvider>(context, listen: false).clockOut();
          Navigator.push(
              context,
              SlideTransitionPage(
                page: GenerateJobReportScreen(
                  jobTitle: widget.jobTitle,
                  jobId: widget.JobId,
                ),
              ));

          final SharedPreferences sp = await SharedPreferences.getInstance();
          sp.remove('currentJobId');
          Utils.showFlushbar('Clock-Out request Successful', context);
        } else {
          Utils.showFlushbar(
              'Clock-Out request failed: ${result['message']}', context);
          print('Clock-Out request failed: ${result['message']}');
        }
      } finally {
        // provider.resetLoading(); // optional
      }
    }
  }

  @override
  void dispose() {
    // ✅ FIX 7: Null-safe dispose — no crash if controller was never initialized
    controller?.dispose();
    super.dispose();
  }
}