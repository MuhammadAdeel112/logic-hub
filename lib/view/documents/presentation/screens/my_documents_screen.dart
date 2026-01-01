import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/view/documents/presentation/screens/view_document.dart';
import 'package:divine_employee_app/api_provider/search_provider.dart';

import '../../../../core/common widgets/resueable_error_screen.dart';
import '../../../../core/common widgets/resueable_search_widget.dart';
import '../../../../core/constants/app_constants.dart';

class MyDocumentsScreen extends StatelessWidget {
  const MyDocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employeeProfile =
        Provider.of<DataProviderForEmployeeProfile?>(context)?.employeeProfile;

    if (employeeProfile == null) {
        return ResueAbleErrorScreen(
          errorMsg: 'No Document Available.',
        );
      
    }
    final docList = employeeProfile.employee.doc;

    // Filter documents with status == false initially
    final initialDocList = docList.where((doc) => doc.status == true).toList();

    // Use Consumer to listen for changes in the search query
    return Consumer<DocumentSearchProvider>(
      builder: (context, searchProvider, child) {
        // Filter documents based on search query
        final filteredDocList = searchProvider.searchQuery.isEmpty
            ? initialDocList
            : initialDocList
                .where((doc) => doc.title.toLowerCase().contains(
                      searchProvider.searchQuery.toLowerCase(),
                    ))
                .toList();

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: ResueableSearchWidget(
                searchController: searchProvider.searchController,
                onChanged: (query) {
                  searchProvider.updateSearch(query, initialDocList);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredDocList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideTransitionPage(
                          page: ViewDocument(
                            src: filteredDocList[index].fileurl,
                            title: filteredDocList[index].title,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                            color: AppConstants.kcwhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: AppConstants.kShadows),
                        child: ListTile(
                          title: Text(filteredDocList[index].title),
                          subtitle: Text(filteredDocList[index].details),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Expiry Date'),
                              Text(
                                filteredDocList[index].date.day.toString() +
                                    '/' +
                                    filteredDocList[index]
                                        .date
                                        .month
                                        .toString() +
                                    '/' +
                                    filteredDocList[index].date.year.toString(),
                              ),
                            ],
                          ),
                          leading: Container(
                            decoration: ShapeDecoration(
                              // color: Colors.amber,
                              gradient: AppConstants.kgradientScreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.sticky_note_2_sharp,
                                color: AppConstants.kcwhiteColor,
                              ),
                            ),
                          ),
                          titleTextStyle:
                              AppConstants.kTextStyleMediumBoldBlack,
                          subtitleTextStyle:
                              AppConstants.kTextStyleSmallBoldGrey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
