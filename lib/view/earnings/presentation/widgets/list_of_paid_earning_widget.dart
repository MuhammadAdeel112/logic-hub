import 'package:divine_employee_app/api_provider/get_invoices_api_provider.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:divine_employee_app/models/get_invoice_model.dart';
import 'package:divine_employee_app/view/earnings/presentation/screens/invoice_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class ListOfPaidEarningWidget extends StatefulWidget {
  const ListOfPaidEarningWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListOfPaidEarningWidget> createState() =>
      _ListOfPaidEarningWidgetState();
}

class _ListOfPaidEarningWidgetState
    extends State<ListOfPaidEarningWidget> {
  Future<GetInvoiceModel>? viewInvoices;
  @override
  initState() {
    viewInvoices = GetInvoiceProvider().fetchInvocies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<GetInvoiceModel>(
                      future: viewInvoices,
                      builder:
                          (context, AsyncSnapshot<GetInvoiceModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.employeeInvoic.isEmpty) {
                          return Center(child: Text('No Invoice Available.'));
                        } else {
                          GetInvoiceModel invoices = snapshot.data!;

                          // Separate paid and unpaid invoices
                          List<EmployeeInvoic> paidInvoices = invoices
                              .employeeInvoic
                              .where((invoice) => invoice.status == 'paid')
                              .toList();

                          return ListView.builder(
                            itemCount: paidInvoices.length,
                            itemBuilder: (context, outerIndex) {
                              EmployeeInvoic invoice = paidInvoices[outerIndex];

                              return Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 18.0),
                                        padding: EdgeInsets.all(4),
                                        decoration: AppConstants
                                            .KContainerStyleForTextFormField,
                                        child: Text(invoice.fromDate.day
                                                .toString() +
                                            '/' +
                                            invoice.fromDate.month.toString() +
                                            '/' +
                                            invoice.fromDate.year.toString() +
                                            '/' +
                                            ' - ' +
                                            invoice.toDate.day.toString() +
                                            '/' +
                                            invoice.toDate.month.toString() +
                                            '/' +
                                            invoice.toDate.year.toString()),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          SlideTransitionPage(
                                              page: InvoiceDetilasScreen(
                                                  employeeInvoic: invoice)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 18.0),
                                      padding: EdgeInsets.all(0),
                                      decoration: AppConstants
                                          .KContainerStyleForTextFormField,
                                      child: ListTile(
                                          title: Text('Total Pay: ' +
                                              invoice.totalPayment),
                                          subtitle: Text('Gross Pay: ' +
                                              invoice.grosspay.toString()),
                                          trailing: invoice.status == 'unpaid'
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      AppConstants
                                                          .AlertIconPath,
                                                      height: 25,
                                                      color: AppConstants
                                                          .kcprimaryColor,
                                                    ),
                                                    Text('Un-Paid')
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: AppConstants
                                                              .kcprimaryColor,
                                                        ),
                                                        Text('Paid')
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      })),
            ],
          ),
        ),
      ],
    );
  }
}
