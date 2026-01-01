// To parse this JSON data, do
//
//     final getEmployeeModel = getEmployeeModelFromJson(jsonString);

import 'dart:convert';

GetEmployeeModel getEmployeeModelFromJson(String str) =>
    GetEmployeeModel.fromJson(json.decode(str));

String getEmployeeModelToJson(GetEmployeeModel data) =>
    json.encode(data.toJson());

class GetEmployeeModel {
  final Employee employee;
  final int status;

  GetEmployeeModel({
    required this.employee,
    required this.status,
  });

  factory GetEmployeeModel.fromJson(Map<String, dynamic> json) =>
      GetEmployeeModel(
        employee: Employee.fromJson(json["employee"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employee": employee.toJson(),
        "status": status,
      };
}

class Employee {
  final ShiftPaymentRates dayShiftPaymentRates;
  final ShiftPaymentRates nightShiftPaymentRates;
  final dynamic id;
  final dynamic companyId;
  final dynamic managerId;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic address;
  final dynamic drivingLicense;
  final dynamic employeeType;
  final dynamic category;
  final int allowedworkinghours;
  final List<Doc> doc;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final int v;
  final dynamic imageUrl;
  final List<PaymentHistory> paymentHistory;
  final dynamic currentworkinghours;
  final dynamic totalPayment;
  final DateTime dob;
  dynamic isDelete;
  dynamic isNew;

  Employee({
    required this.dayShiftPaymentRates,
    required this.nightShiftPaymentRates,
    required this.id,
    required this.companyId,
    required this.managerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.drivingLicense,
    required this.employeeType,
    required this.category,
    required this.allowedworkinghours,
    required this.doc,
    // required this.createdAt,
    // required this.updatedAt,
    required this.v,
    required this.imageUrl,
    required this.paymentHistory,
    required this.currentworkinghours,
    required this.totalPayment,
    required this.dob,
    required this.isDelete,
    required this.isNew,
  });
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      dayShiftPaymentRates:
          ShiftPaymentRates.fromJson(json["dayShiftPaymentRates"] ?? {}),
      nightShiftPaymentRates:
          ShiftPaymentRates.fromJson(json["nightShiftPaymentRates"] ?? {}),
      id: json["_id"] ?? '',
      companyId: json["companyId"] ?? '',
      managerId: json["managerId"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
      address: json["address"] ?? '',
      drivingLicense: json["driving_license"] ?? '',
      employeeType: json["employeeType"] ?? '',
      category: json["category"] ?? '',
      allowedworkinghours: json["allowedworkinghours"] ?? 0,
      doc: List<Doc>.from((json["doc"] ?? []).map((x) => Doc.fromJson(x))),
      // createdAt: DateTime.parse(json["createdAt"] ?? ''),
      // updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
      v: json["__v"] ?? 0,
      imageUrl: json["imageUrl"] ?? '',
      paymentHistory: List<PaymentHistory>.from((json["paymentHistory"] ?? [])
          .map((x) => PaymentHistory.fromJson(x))),
      currentworkinghours: json["currentworkinghours"]?.toDouble() ?? 0.0,
      totalPayment: json["totalPayment"] ?? '',
      dob: DateTime.parse(json["DOB"] ?? ''),
      isDelete: json["isDelete"],
      isNew: json["isNew"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dayShiftPaymentRates": dayShiftPaymentRates.toJson(),
        "nightShiftPaymentRates": nightShiftPaymentRates.toJson(),
        "_id": id,
        "companyId": companyId,
        "managerId": managerId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "driving_license": drivingLicense,
        "employeeType": employeeType,
        "category": category,
        "allowedworkinghours": allowedworkinghours,
        "doc": List<dynamic>.from(doc.map((x) => x.toJson())),
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "imageUrl": imageUrl,
        "paymentHistory":
            List<dynamic>.from(paymentHistory.map((x) => x.toJson())),
        "currentworkinghours": currentworkinghours,
        "totalPayment": totalPayment,
        "DOB": dob.toIso8601String(),
        "isDelete": isDelete,
        "isNew": isNew,
      };
}

class ShiftPaymentRates {
  final dynamic normal;
  final dynamic saturday;
  final dynamic sunday;
  final dynamic holidays;

  ShiftPaymentRates({
    required this.normal,
    required this.saturday,
    required this.sunday,
    required this.holidays,
  });
  factory ShiftPaymentRates.fromJson(Map<String, dynamic> json) {
    return ShiftPaymentRates(
      normal: json["normal"] ?? 0,
      saturday: json["saturday"] ?? 0,
      sunday: json["sunday"] ?? 0,
      holidays: json["holidays"] ?? 0,
    );
  }
  // factory ShiftPaymentRates.fromJson(Map<String, dynamic> json) =>
  //     ShiftPaymentRates(
  //       normal: json["normal"],
  //       saturday: json["saturday"],
  //       sunday: json["sunday"],
  //       holidays: json["holidays"],
  //     );

  Map<String, dynamic> toJson() => {
        "normal": normal,
        "saturday": saturday,
        "sunday": sunday,
        "holidays": holidays,
      };
}

class Doc {
  final dynamic title;
  final dynamic details;
  final dynamic fileurl;
  final DateTime date;
  final dynamic status;
  final dynamic id;

  Doc({
    required this.title,
    required this.details,
    required this.fileurl,
    required this.date,
    required this.status,
    required this.id,
  });
  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        title: json["title"] ?? '',
        details: json["details"] ?? '',
        fileurl: json["fileurl"] ?? '',
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        status: json["status"] ?? false,
        id: json["_id"] ?? '',
      );

  // factory Doc.fromJson(Map<String, dynamic> json) => Doc(
  //       title: json["title"],
  //       details: json["details"],
  //       fileurl: json["fileurl"],
  //       date: DateTime.parse(json["date"]),
  //       status: json["status"],
  //       id: json["_id"],
  //     );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
        "fileurl": fileurl,
        "date": date.toIso8601String(),
        "status": status,
        "_id": id,
      };
}

class PaymentHistory {
  final DateTime date;
  final List<Record> records;

  PaymentHistory({
    required this.date,
    required this.records,
  });
  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        records: (json["records"] as List<dynamic>? ?? [])
            .map((x) => Record.fromJson(x))
            .toList(),
      );

  // factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
  //       date: DateTime.parse(json["date"]),
  //       records:
  //           List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class Record {
  final DateTime clockin;
  final DateTime? clockout;
  final dynamic workingHours;
  final dynamic totalPayment;
  final dynamic id;

  Record({
    required this.clockin,
    required this.clockout,
    required this.workingHours,
    required this.totalPayment,
    required this.id,
  });
  factory Record.fromJson(Map<String, dynamic> json) => Record(
        clockin: DateTime.parse(json["clockin"] ?? ''),
        clockout:
            json["clockout"] != null ? DateTime.parse(json["clockout"]) : null,
        workingHours: json["workingHours"]?.toDouble() ?? 0.0,
        totalPayment: json["totalPayment"]?.toDouble() ?? 0.0,
        id: json["_id"] ?? '',
      );

  // factory Record.fromJson(Map<String, dynamic> json) => Record(
  //       clockin: DateTime.parse(json["clockin"]),
  //       clockout:
  //           json["clockout"] == null ? null : DateTime.parse(json["clockout"]),
  //       workingHours: json["workingHours"]?.toDouble(),
  //       totalPayment: json["totalPayment"]?.toDouble(),
  //       id: json["_id"],
  //     );

  Map<String, dynamic> toJson() => {
        "clockin": clockin.toIso8601String(),
        "clockout": clockout?.toIso8601String(),
        "workingHours": workingHours,
        "totalPayment": totalPayment,
        "_id": id,
      };
}
