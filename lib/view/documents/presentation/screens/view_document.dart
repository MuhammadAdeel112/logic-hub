import 'package:divine_employee_app/core/common%20widgets/reuseable_sccafold_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewDocument extends StatelessWidget {
  final src;
  final title;
  const ViewDocument({super.key, required this.src, required this.title});

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffoldScreen(
      appBarTitle: title,
      content: SizedBox(
        child: SfPdfViewer.network(src),
      ),
    );
  }
}
