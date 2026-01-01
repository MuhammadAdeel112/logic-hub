// // To parse this JSON data, do
// //
// //     final allChatsModel = allChatsModelFromJson(jsonString);

// import 'dart:convert';

// AllChatsModel allChatsModelFromJson(String str) => AllChatsModel.fromJson(json.decode(str));

// String allChatsModelToJson(AllChatsModel data) => json.encode(data.toJson());

// class AllChatsModel {
//     List<Chats> data;
//     int status;

//     AllChatsModel({
//         required this.data,
//         required this.status,
//     });

//     factory AllChatsModel.fromJson(Map<String, dynamic> json) => AllChatsModel(
//         data: List<Chats>.from(json["data"].map((x) => Chats.fromJson(x))),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "status": status,
//     };
// }

// class Chats {
//     String chatId;
//     String name;
//     String imageUrl;
//     bool isGroupChat;
//     String jobId;
//     List<String> members;
//     DateTime createdAt;
//     DateTime updatedAt;

//     Chats({
//         required this.chatId,
//         required this.name,
//         required this.imageUrl,
//         required this.isGroupChat,
//         required this.jobId,
//         required this.members,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory Chats.fromJson(Map<String, dynamic> json) => Chats(
//         chatId: json["chatId"],
//         name: json["name"],
//         imageUrl: json["imageUrl"],
//         isGroupChat: json["isGroupChat"],
//         jobId: json["jobId"],
//         members: List<String>.from(json["members"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "chatId": chatId,
//         "name": name,
//         "imageUrl": imageUrl,
//         "isGroupChat": isGroupChat,
//         "jobId": jobId,
//         "members": List<dynamic>.from(members.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }

import 'dart:convert';

AllChatsModel allChatsModelFromJson(String str) => AllChatsModel.fromJson(json.decode(str));

String allChatsModelToJson(AllChatsModel data) => json.encode(data.toJson());

class AllChatsModel {
    List<Datum> data;
    int status;

    AllChatsModel({
        required this.data,
        required this.status,
    });

    factory AllChatsModel.fromJson(Map<String, dynamic> json) => AllChatsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    String chatId;
    String? name;
    String? imageUrl;
    bool isGroupChat;
    String? jobId;
    List<String> members;
    DateTime createdAt;
    DateTime updatedAt;
    String? groupName;
    List<MemberDetail>? memberDetails;

    Datum({
        required this.chatId,
        this.name,
        this.imageUrl,
        required this.isGroupChat,
        this.jobId,
        required this.members,
        required this.createdAt,
        required this.updatedAt,
        this.groupName,
        this.memberDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chatId: json["chatId"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        isGroupChat: json["isGroupChat"],
        jobId: json["jobId"],
        members: List<String>.from(json["members"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        groupName: json["groupName"],
        memberDetails: json["memberDetails"] == null ? [] : List<MemberDetail>.from(json["memberDetails"]!.map((x) => MemberDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "name": name,
        "imageUrl": imageUrl,
        "isGroupChat": isGroupChat,
        "jobId": jobId,
        "members": List<dynamic>.from(members.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "groupName": groupName,
        "memberDetails": memberDetails == null ? [] : List<dynamic>.from(memberDetails!.map((x) => x.toJson())),
    };
}

class MemberDetail {
    String id;
    String name;
    String? imageUrl;

    MemberDetail({
        required this.id,
        required this.name,
        this.imageUrl,
    });

    factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
    };
}
