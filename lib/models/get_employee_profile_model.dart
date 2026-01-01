// // To parse this JSON data, do
// //
// //     final getEmployeeProfileModel = getEmployeeProfileModelFromJson(jsonString);

// import 'dart:convert';

// GetEmployeeProfileModel getEmployeeProfileModelFromJson(String str) => GetEmployeeProfileModel.fromJson(json.decode(str));

// String getEmployeeProfileModelToJson(GetEmployeeProfileModel data) => json.encode(data.toJson());

// class GetEmployeeProfileModel {
//     final Employee employee;
//     final int status;

//     GetEmployeeProfileModel({
//         required this.employee,
//         required this.status,
//     });

//     factory GetEmployeeProfileModel.fromJson(Map<String, dynamic> json) => GetEmployeeProfileModel(
//         employee: Employee.fromJson(json["employee"]),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "employee": employee.toJson(),
//         "status": status,
//     };
// }

// class Employee {
//     final DayShiftPaymentRates dayShiftWorkingHours;
//     final DayShiftPaymentRates nightShiftWorkingHours;
//     final DayShiftPaymentRates dayShiftPaymentRates;
//     final DayShiftPaymentRates nightShiftPaymentRates;
//     final String id;
//     final String companyId;
//     final String managerId;
//     final String name;
//     final String email;
//     final String phone;
//     final String address;
//     final String drivingLicense;
//     final String employeeType;
//     final String category;
//     final int allowedworkinghours;
//     final List<dynamic> doc;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final int v;
//     final String imageUrl;
//     final List<PaymentHistory> paymentHistory;
//     final double currentworkinghours;
//     final String totalPayment;

//     Employee({
//         required this.dayShiftWorkingHours,
//         required this.nightShiftWorkingHours,
//         required this.dayShiftPaymentRates,
//         required this.nightShiftPaymentRates,
//         required this.id,
//         required this.companyId,
//         required this.managerId,
//         required this.name,
//         required this.email,
//         required this.phone,
//         required this.address,
//         required this.drivingLicense,
//         required this.employeeType,
//         required this.category,
//         required this.allowedworkinghours,
//         required this.doc,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.imageUrl,
//         required this.paymentHistory,
//         required this.currentworkinghours,
//         required this.totalPayment,
//     });

//     factory Employee.fromJson(Map<String, dynamic> json) => Employee(
//         dayShiftWorkingHours: DayShiftPaymentRates.fromJson(json["dayShiftWorkingHours"]),
//         nightShiftWorkingHours: DayShiftPaymentRates.fromJson(json["nightShiftWorkingHours"]),
//         dayShiftPaymentRates: DayShiftPaymentRates.fromJson(json["dayShiftPaymentRates"]),
//         nightShiftPaymentRates: DayShiftPaymentRates.fromJson(json["nightShiftPaymentRates"]),
//         id: json["_id"],
//         companyId: json["companyId"],
//         managerId: json["managerId"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         address: json["address"],
//         drivingLicense: json["driving_license"],
//         employeeType: json["employeeType"],
//         category: json["category"],
//         allowedworkinghours: json["allowedworkinghours"],
//         doc: List<dynamic>.from(json["doc"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         imageUrl: json["imageUrl"],
//         paymentHistory: List<PaymentHistory>.from(json["paymentHistory"].map((x) => PaymentHistory.fromJson(x))),
//         currentworkinghours: json["currentworkinghours"]?.toDouble(),
//         totalPayment: json["totalPayment"],
//     );

//     Map<String, dynamic> toJson() => {
//         "dayShiftWorkingHours": dayShiftWorkingHours.toJson(),
//         "nightShiftWorkingHours": nightShiftWorkingHours.toJson(),
//         "dayShiftPaymentRates": dayShiftPaymentRates.toJson(),
//         "nightShiftPaymentRates": nightShiftPaymentRates.toJson(),
//         "_id": id,
//         "companyId": companyId,
//         "managerId": managerId,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "address": address,
//         "driving_license": drivingLicense,
//         "employeeType": employeeType,
//         "category": category,
//         "allowedworkinghours": allowedworkinghours,
//         "doc": List<dynamic>.from(doc.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "imageUrl": imageUrl,
//         "paymentHistory": List<dynamic>.from(paymentHistory.map((x) => x.toJson())),
//         "currentworkinghours": currentworkinghours,
//         "totalPayment": totalPayment,
//     };
// }

// class DayShiftPaymentRates {
//     final int normal;
//     final int saturday;
//     final int sunday;
//     final int holidays;

//     DayShiftPaymentRates({
//         required this.normal,
//         required this.saturday,
//         required this.sunday,
//         required this.holidays,
//     });

//     factory DayShiftPaymentRates.fromJson(Map<String, dynamic> json) => DayShiftPaymentRates(
//         normal: json["normal"],
//         saturday: json["saturday"],
//         sunday: json["sunday"],
//         holidays: json["holidays"],
//     );

//     Map<String, dynamic> toJson() => {
//         "normal": normal,
//         "saturday": saturday,
//         "sunday": sunday,
//         "holidays": holidays,
//     };
// }

// class PaymentHistory {
//     final DateTime date;
//     final List<Record> records;

//     PaymentHistory({
//         required this.date,
//         required this.records,
//     });

//     factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
//         date: DateTime.parse(json["date"]),
//         records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "date": date.toIso8601String(),
//         "records": List<dynamic>.from(records.map((x) => x.toJson())),
//     };
// }

// class Record {
//     final DateTime clockin;
//     final DateTime clockout;
//     final double workingHours;
//     final double totalPayment;
//     final String id;

//     Record({
//         required this.clockin,
//         required this.clockout,
//         required this.workingHours,
//         required this.totalPayment,
//         required this.id,
//     });

//     factory Record.fromJson(Map<String, dynamic> json) => Record(
//         clockin: DateTime.parse(json["clockin"]),
//         clockout: DateTime.parse(json["clockout"]),
//         workingHours: json["workingHours"]?.toDouble(),
//         totalPayment: json["totalPayment"]?.toDouble(),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "clockin": clockin.toIso8601String(),
//         "clockout": clockout.toIso8601String(),
//         "workingHours": workingHours,
//         "totalPayment": totalPayment,
//         "_id": id,
//     };
// }
