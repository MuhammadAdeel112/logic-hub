import 'dart:async';
import 'dart:io';

import 'package:divine_employee_app/api_provider/data_provider_for_employee_profile.dart';
import 'package:divine_employee_app/api_provider/session_handling_view_model.dart';
import 'package:divine_employee_app/core/constants/api_end_points.dart';
import 'package:divine_employee_app/core/data/app_exception.dart';
import 'package:divine_employee_app/core/data/response/api_response.dart';
import 'package:divine_employee_app/models/single_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import '../widgets/chat_message_widget.dart';

class ChatState extends ChangeNotifier {
  SingleChatModel? _singlechats;
  SingleChatModel? get singleChats => _singlechats;

  ApiReponses<SingleChatModel> _apiResponse = ApiReponses.loading();

  ApiReponses<SingleChatModel> get singleChatapiResponse => _apiResponse;

  late IO.Socket socket;

  List<ChatMessageWidget> _groupMeassage = [];
  List<ChatMessageWidget> get groupMeassage => _groupMeassage;

  List<ChatMessageWidget> _messages = [];
  List<ChatMessageWidget> get messages => _messages;

  void connect(String myId, ScrollController _scrollController) {
    socket = IO.io(ApiEndPoints.baseUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onDisconnect((data) => print('disconnected'));
    socket.onConnect((data) {
      print("::: Connected");
      socket.emit("new-user-add", myId);
      // socket.on('event', (data) => print(data));

      socket.on("receive-message", (msg) {
        print(':::on receive-message $msg');
        _addReceivedMessage(msg, myId, _scrollController);
      });
      socket.on("receive-group-message", (msg) {
        print(':::on receive-group-message $msg');
        _addReceivedGroupMessage(msg, myId, _scrollController);
      });
    });
    print(socket.connected);
  }

  void _addReceivedMessage(
      dynamic msg, String myId, ScrollController _scrollController) {
    String messageId = msg['_id']; // Assuming '_id' is the unique identifier
    String senderId = msg['senderId'];

    if (senderId != myId) {
      // Check if the message ID already exists in the list
      if (!_messages.any((message) => message.messageId == messageId)) {
        ChatMessageWidget receivedMessage = ChatMessageWidget(
          messageId: messageId, // Add the unique message ID
          isSent: false,
          text: msg['content'],
          time: DateTime.parse(msg['createdAt']),
          sender: '',
        );

        // Add the sent message to the end of the list
        _messages.add(receivedMessage);

        // Notify listeners
        notifyListeners();

        // Check if the ScrollController is attached
        if (_scrollController.hasClients) {
          // Set the initial scroll position to the maximum extent
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
        }
      }
    }
  }

  void _addReceivedGroupMessage(
      dynamic msg, String myId, ScrollController _scrollController) {
    String senderName = msg['_doc']['senderName'];
    String senderId = msg['_doc']['senderId'];
    String messageId = msg['_doc']['_id'];

    String content = msg['_doc']['content'];
    DateTime createdAt = DateTime.parse(msg['_doc']['createdAt']);

    print(':::messageIdmessageId ${messageId}');
    // Check if the received message is not from you
    if (senderId != myId) {
      if (!_messages.any((message) => message.messageId == messageId)) {
        ChatMessageWidget receivedMessage = ChatMessageWidget(
          messageId: messageId,
          isSent: false,
          text: content,
          time: createdAt,
          sender: senderName,
        );
        // Add the sent message to the end of the list
        _groupMeassage.add(receivedMessage);
        // _messages.insert(0, receivedMessage);
        notifyListeners();
        if (_scrollController.hasClients) {
          // Set the initial scroll position to the maximum extent
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
        }
      }
    }
  }

  void sendMessage(
      String message,
      String senderId,
      String receiverId,
      String chatId,
      _scrollController,
      notificationPayload,
      bool isSingleChat) {
    // Assuming you have a timestamp for the sent message
    DateTime sentTime = DateTime.now();
    // UniqueKey uniqueKey = UniqueKey();

    // Create the ChatMessageWidget for the sent message
    ChatMessageWidget sentMessage = ChatMessageWidget(
      isSent: true,
      text: message,
      time: sentTime,
      sender: '',
    );

    // Add the sent message to the end of the list
    if (isSingleChat) {
      _messages.add(sentMessage);
      notifyListeners();
    } else {
      _groupMeassage.add(sentMessage);
      notifyListeners();
    }

    // print('::: while emmiting receiverId ${receiverId}');
    // print('::: while emmiting senderId ${senderId}');
    // print('::: while emmiting chatId ${chatId}');
    // Emit the message to the server
    // receiverId, senderId, chatId, content
    receiverId != ''
        ? socket.emit("send-message", {
            "content": message,
            "senderId": senderId,
            "receiverId": receiverId,
            "chatId": chatId,
            'notificationPayload': notificationPayload
          })
        : socket.emit("send-message", {
            "content": message,
            "senderId": senderId,
            "chatId": chatId,
            'notificationPayload': notificationPayload
          });
  }

  // void disposeConnection() {
  //   socket.disconnect();
  // }
    void disposeConnection() {
    socket.disconnect();
    socket.clearListeners();
    socket.dispose();
    socket.destroy();
  }

  void clearMessageList() {
    _messages = [];
    _groupMeassage = [];
  }

  Future<void> fetchChatRoom(String chatId, bool isSingleChat) async {
    try {
      // Set loading state
      _apiResponse = ApiReponses.loading();
      notifyListeners();
      var userId = await SessionHandlingViewModel().getMyId();

      var i = await SessionHandlingViewModel().getToken();
      await Future.delayed(Duration(seconds: 0));

      var url = Uri.parse(ApiEndPoints.chatRoom(chatId));
      var response = await http.get(url,
          headers: {'x-auth-token': "$i"}).timeout(Duration(seconds: 10));

      // Handle the response using the returnResponse function
      dynamic responseBody = returnResponse(response);
      // Convert the JSON response to AvailableJobsModel
      final SingleChatModel allchats = SingleChatModel.fromJson(responseBody);

      // Set completed state with data
      _apiResponse = ApiReponses.completed(allchats);
      _singlechats = allchats;

      // Update _messages list with the chat messages
      if (isSingleChat == true) {
        _messages = allchats.data.map((chat) {
          return ChatMessageWidget(
            messageId: chat.id,
            isSent: chat.senderId == userId, // Set based on senderId
            text: chat.content,
            time: chat.createdAt,
            sender: chat.senderId != userId ? chat.senderName ?? '' : '',
          );
        }).toList();
        notifyListeners();
      } else {
        _groupMeassage = allchats.data.map((chat) {
          return ChatMessageWidget(
            messageId: chat.id,
            isSent: chat.senderId == userId, // Set based on senderId
            text: chat.content,
            time: chat.createdAt,
            sender: chat.senderId != userId ? chat.senderName ?? '' : '',
          );
        }).toList();
        notifyListeners();
      }
    } on SocketException catch (_) {
      // Handle socket exception (no internet connection)
      _apiResponse = ApiReponses.error('No internet connection');
      notifyListeners();
    } on TimeoutException catch (_) {
      // Handle timeout exception
      _apiResponse = ApiReponses.error('Request timeout');
      notifyListeners();
    } on AppException catch (e) {
      // Handle custom app exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    } on Exception catch (e) {
      // Handle other exceptions
      _apiResponse = ApiReponses.error(e.toString());
      notifyListeners();
    }
  }
}
