import 'dart:convert';

AllNotificationsModel allNotificationsModelFromJson(String str) => AllNotificationsModel.fromJson(json.decode(str));

String allNotificationsModelToJson(AllNotificationsModel data) => json.encode(data.toJson());

class AllNotificationsModel {
  List<NotificationItem> notifications; // Spelling fixed
  int status;

  AllNotificationsModel({
    required this.notifications,
    required this.status,
  });

  factory AllNotificationsModel.fromJson(Map<String, dynamic> json) => AllNotificationsModel(
    notifications: json["notifications"] == null
        ? []
        : List<NotificationItem>.from(json["notifications"].map((x) => NotificationItem.fromJson(x))),
    status: json["status"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
    "status": status,
  };
}

class NotificationItem {
  String id;
  String? managerId;
  String? companyId;
  String title;
  String body;
  String type;
  String? priority;
  bool isRead;
  bool isActionPerform;
  DateTime? createdAt;
  DateTime? updatedAt;
  int v;

  NotificationItem({
    required this.id,
    this.managerId,
    this.companyId,
    required this.title,
    required this.body,
    required this.type,
    this.priority,
    required this.isRead,
    required this.isActionPerform,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["_id"] ?? "",
    managerId: json["managerId"],
    companyId: json["companyId"],
    title: json["title"] ?? "",
    body: json["body"] ?? "",
    type: json["type"] ?? "",
    priority: json["priority"],
    isRead: json["is_read"] ?? false,
    isActionPerform: json["is_action_perform"] ?? false,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "companyId": companyId,
    "title": title,
    "body": body,
    "type": type,
    "priority": priority,
    "is_read": isRead,
    "is_action_perform": isActionPerform,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}