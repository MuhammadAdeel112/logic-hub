// To parse this JSON data, do
//
//     final getRosterModel = getRosterModelFromJson(jsonString);

import 'dart:convert';

GetRosterModel getRosterModelFromJson(String str) => GetRosterModel.fromJson(json.decode(str));

String getRosterModelToJson(GetRosterModel data) => json.encode(data.toJson());

class GetRosterModel {
    String employeeId;
    String employeeName;
    List<ShiftInRoster> shifts;

    GetRosterModel({
        required this.employeeId,
        required this.employeeName,
        required this.shifts,
    });

    factory GetRosterModel.fromJson(Map<String, dynamic> json) => GetRosterModel(
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        shifts: List<ShiftInRoster>.from(json["shifts"].map((x) => ShiftInRoster.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeName": employeeName,
        "shifts": List<dynamic>.from(shifts.map((x) => x.toJson())),
    };
}

class ShiftInRoster {
    DateTime startTime;
    DateTime endTime;
    String taskDetail;
    String clientId;
    String clientName;
    String id;

    ShiftInRoster({
        required this.startTime,
        required this.endTime,
        required this.taskDetail,
        required this.clientId,
        required this.clientName,
        required this.id,
    });

    factory ShiftInRoster.fromJson(Map<String, dynamic> json) => ShiftInRoster(
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        taskDetail: json["taskDetail"],
        clientId: json["clientId"],
        clientName: json["clientName"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "taskDetail": taskDetail,
        "clientId": clientId,
        "clientName": clientName,
        "_id": id,
    };
}
