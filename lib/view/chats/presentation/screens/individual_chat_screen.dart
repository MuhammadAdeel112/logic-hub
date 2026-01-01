import 'package:divine_employee_app/api_provider/fetch_all_chats_api_provider.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/config/routes/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/data/response/status.dart';
import 'individual_chat_room_screen.dart';

class IndividualChatScreen extends StatefulWidget {
  IndividualChatScreen({super.key});

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  late AllChatsProvider _allChatsProvider;

  @override
  void initState() {
    _allChatsProvider = Provider.of<AllChatsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _allChatsProvider.fetchAllChats();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 9.0),
        //   child: ResueableSearchWidget(
        //     searchController: controller,
        //     onChanged: () {},
        //   ),
        // ),
        ChangeNotifierProvider.value(
          value: _allChatsProvider,
          child: Consumer<AllChatsProvider>(
            builder: (context, value, child) {
              switch (value.apiResponse.status) {
                case Status.LOADING:
                  // return Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: ListView.builder(
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Center(
                  //           child: Container(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Container(
                  //             padding: EdgeInsets.all(4),
                  //             decoration: ShapeDecoration(
                  //               color: AppConstants.kcwhiteColor,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //             ),
                  //             child: ListTile(
                  //               title: Text('myChats[index].name'),
                  //               subtitle: Text('2 days ago'),
                  //               leading: CircleAvatar(
                  //                 radius: 25,
                  //               ),
                  //               trailing: Text('3:02 pm'),
                  //               titleTextStyle:
                  //                   AppConstants.kTextStyleMediumBoldBlack,
                  //               subtitleTextStyle:
                  //                   AppConstants.kTextStyleSmallBoldGrey,
                  //             ),
                  //           ),
                  //         ),
                  //       ));
                  //     },
                  //   ),
                  // );
                  return MyShimmeringWidget();
                case Status.ERROR:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: value.apiResponse.message!
                                .contains('Chat not found')
                            ? Text('No Chats')
                            : Text(
                                value.apiResponse.message ?? 'Error',
                              ),
                      )
                    ],
                  );
                case Status.COMPLETED:
                  final myChats = value.allChats!.data
                      .where(
                        (chats) => chats.isGroupChat == false,
                      )
                      .toList();
                  if (myChats.length == 0) {
                    return Center(
                        child: Text(
                      'No Chats',
                    ));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: myChats.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              var my_id =
                                  await SessionHandlingViewModel().getMyId();
                              var receiverId = myChats[index]
                                  .members
                                  .firstWhere((element) => element != my_id,
                                      orElse: () => '');

                              Navigator.push(
                                  context,
                                  SlideTransitionPage(
                                      page: IndividualChatRoomScreen(
                                    name: myChats[index].name,
                                    recevierId: receiverId,
                                    JobId: myChats[index].jobId,
                                    chatId: myChats[index].chatId,
                                  )));
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
                                  // shadows: AppConstants.kShadows
                                ),
                                child: ListTile(
                                  title: Text(myChats[index].name ?? ''),
                                  // subtitle: Text('2 days ago'),
                                  leading: myChats[index].imageUrl == null
                                      ? CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                              AppConstants.userIconPath),
                                        )
                                      : CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                            myChats[index].imageUrl!,
                                          )),
                                  // trailing: Text('3:02 pm'),
                                  titleTextStyle:
                                      AppConstants.kTextStyleMediumBoldBlack,
                                  subtitleTextStyle:
                                      AppConstants.kTextStyleSmallBoldGrey,
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                case null:
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}

class MyShimmeringWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 10, // Adjust the itemCount according to your needs
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: AppConstants.kcwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: ListTile(
                    title: Text(''),
                    subtitle: Text(''),
                    leading: CircleAvatar(
                      radius: 25,
                    ),
                    trailing: Text(''),
                    titleTextStyle: AppConstants.kTextStyleMediumBoldBlack,
                    subtitleTextStyle: AppConstants.kTextStyleSmallBoldGrey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
