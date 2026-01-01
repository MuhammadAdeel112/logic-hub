import 'dart:convert';

SingleChatModel singleChatModelFromJson(String str) => SingleChatModel.fromJson(json.decode(str));

String singleChatModelToJson(SingleChatModel data) => json.encode(data.toJson());

class SingleChatModel {
    List<Datum> data;
    int status;

    SingleChatModel({
        required this.data,
        required this.status,
    });

    factory SingleChatModel.fromJson(Map<String, dynamic> json) => SingleChatModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    String id;
    String senderId;
    String content;
    String chatId;
    String? senderName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.senderId,
        required this.content,
        required this.chatId,
        required this.senderName,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        senderId: json["senderId"],
        content: json["content"],
        chatId: json["chatId"],
        senderName: json["senderName"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "senderId": senderId,
        "content": content,
        "chatId": chatId,
        "senderName": senderName ?? '',
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
