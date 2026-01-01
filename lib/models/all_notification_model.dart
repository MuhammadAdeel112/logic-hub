// To parse this JSON data, do
//
//     final allNotificationsModel = allNotificationsModelFromJson(jsonString);

import 'dart:convert';

AllNotificationsModel allNotificationsModelFromJson(String str) => AllNotificationsModel.fromJson(json.decode(str));

String allNotificationsModelToJson(AllNotificationsModel data) => json.encode(data.toJson());

class AllNotificationsModel {
    List<Notifcation> notifcation;
    int status;

    AllNotificationsModel({
        required this.notifcation,
        required this.status,
    });

    factory AllNotificationsModel.fromJson(Map<String, dynamic> json) => AllNotificationsModel(
        notifcation: List<Notifcation>.from(json["notifcation"].map((x) => Notifcation.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "notifcation": List<dynamic>.from(notifcation.map((x) => x.toJson())),
        "status": status,
    };
}

class Notifcation {
    String id;
    String userId;
    String title;
    String body;
    String type;
    bool isRead;
    bool isActionPerform;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Notifcation({
        required this.id,
        required this.userId,
        required this.title,
        required this.body,
        required this.type,
        required this.isRead,
        required this.isActionPerform,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Notifcation.fromJson(Map<String, dynamic> json) => Notifcation(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        isRead: json["is_read"],
        isActionPerform: json["is_action_perform"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "body": body,
        "type": type,
        "is_read": isRead,
        "is_action_perform": isActionPerform,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
