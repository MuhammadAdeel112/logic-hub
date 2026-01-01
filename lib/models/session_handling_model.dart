// To parse this JSON data, do
//
//     final sessionHandlingModel = sessionHandlingModelFromJson(jsonString);

import 'dart:convert';

SessionHandlingModel sessionHandlingModelFromJson(String str) => SessionHandlingModel.fromJson(json.decode(str));

String sessionHandlingModelToJson(SessionHandlingModel data) => json.encode(data.toJson());

class SessionHandlingModel {
    final String token;
    final int status;

    SessionHandlingModel({
        required this.token,
        required this.status,
    });

    factory SessionHandlingModel.fromJson(Map<String, dynamic> json) => SessionHandlingModel(
        token: json["token"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "status": status,
    };
}
