// To parse this JSON data, do
//
//     final employeeProfileModel = employeeProfileModelFromJson(jsonString);

import 'dart:convert';

EmployeeProfileModel employeeProfileModelFromJson(String str) => EmployeeProfileModel.fromJson(json.decode(str));

String employeeProfileModelToJson(EmployeeProfileModel data) => json.encode(data.toJson());

class EmployeeProfileModel {
  Employee employee;
  int status;

  EmployeeProfileModel({
    required this.employee,
    required this.status,
  });

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) => EmployeeProfileModel(
    employee: Employee.fromJson(json["employee"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "employee": employee.toJson(),
    "status": status,
  };
}

class Employee {
  DayShiftPaymentRates dayShiftWorkingHours;
  DayShiftPaymentRates nightShiftWorkingHours;
  DayShiftPaymentRates dayShiftPaymentRates;
  DayShiftPaymentRates nightShiftPaymentRates;
  String id;
  String companyId;
  String managerId;
  String name;
  String email;
  String phone;
  String address;
  String drivingLicense;
  String employeeType;
  String category;
  int allowedworkinghours;
  List<dynamic> doc;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime startTime;
  DateTime endTime;
  String totalPayment;
  double currentworkinghours;
  String imageUrl;

  Employee({
    required this.dayShiftWorkingHours,
    required this.nightShiftWorkingHours,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.startTime,
    required this.endTime,
    required this.totalPayment,
    required this.currentworkinghours,
    required this.imageUrl,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    dayShiftWorkingHours: DayShiftPaymentRates.fromJson(json["dayShiftWorkingHours"]),
    nightShiftWorkingHours: DayShiftPaymentRates.fromJson(json["nightShiftWorkingHours"]),
    dayShiftPaymentRates: DayShiftPaymentRates.fromJson(json["dayShiftPaymentRates"]),
    nightShiftPaymentRates: DayShiftPaymentRates.fromJson(json["nightShiftPaymentRates"]),
    id: json["_id"],
    companyId: json["companyId"],
    managerId: json["managerId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    drivingLicense: json["driving_license"],
    employeeType: json["employeeType"],
    category: json["category"],
    allowedworkinghours: json["allowedworkinghours"],
    doc: List<dynamic>.from(json["doc"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    totalPayment: json["totalPayment"],
    currentworkinghours: json["currentworkinghours"]?.toDouble(),
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "dayShiftWorkingHours": dayShiftWorkingHours.toJson(),
    "nightShiftWorkingHours": nightShiftWorkingHours.toJson(),
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
    "doc": List<dynamic>.from(doc.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "totalPayment": totalPayment,
    "currentworkinghours": currentworkinghours,
    "imageUrl": imageUrl,
  };
}

class DayShiftPaymentRates {
  double normal;
  int saturday;
  int sunday;
  int holidays;

  DayShiftPaymentRates({
    required this.normal,
    required this.saturday,
    required this.sunday,
    required this.holidays,
  });

  factory DayShiftPaymentRates.fromJson(Map<String, dynamic> json) => DayShiftPaymentRates(
    normal: json["normal"]?.toDouble(),
    saturday: json["saturday"],
    sunday: json["sunday"],
    holidays: json["holidays"],
  );

  Map<String, dynamic> toJson() => {
    "normal": normal,
    "saturday": saturday,
    "sunday": sunday,
    "holidays": holidays,
  };
}
