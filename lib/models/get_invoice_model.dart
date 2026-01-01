// To parse this JSON data, do
//
//     final getInvoiceModel = getInvoiceModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceModel getInvoiceModelFromJson(String str) => GetInvoiceModel.fromJson(json.decode(str));

String getInvoiceModelToJson(GetInvoiceModel data) => json.encode(data.toJson());

class GetInvoiceModel {
    List<EmployeeInvoic> employeeInvoic;
    int status;

    GetInvoiceModel({
        required this.employeeInvoic,
        required this.status,
    });

    factory GetInvoiceModel.fromJson(Map<String, dynamic> json) => GetInvoiceModel(
        employeeInvoic: List<EmployeeInvoic>.from(json["employeeInvoic"].map((x) => EmployeeInvoic.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "employeeInvoic": List<dynamic>.from(employeeInvoic.map((x) => x.toJson())),
        "status": status,
    };
}

class EmployeeInvoic {
    var id;
    var employeeId;
    var totalPayment;
    var currentworkinghours;
    var allowances;
    var extraAmount;
    var grosspay;
    var netpay;
    DateTime fromDate;
    DateTime toDate;
    var taxFreeTrashHold;
    var fortnightlyTax;
    var medicalLeaveyTax;
    var status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    EmployeeInvoic({
        required this.id,
        required this.employeeId,
        required this.totalPayment,
        required this.currentworkinghours,
        required this.allowances,
        required this.extraAmount,
        required this.grosspay,
        required this.netpay,
        required this.fromDate,
        required this.toDate,
        required this.taxFreeTrashHold,
        required this.fortnightlyTax,
        required this.medicalLeaveyTax,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory EmployeeInvoic.fromJson(Map<String, dynamic> json) => EmployeeInvoic(
        id: json["_id"],
        employeeId: json["employeeId"],
        totalPayment: json["totalPayment"],
        currentworkinghours: json["currentworkinghours"],
        allowances: json["allowances"],
        extraAmount: json["extraAmount"],
        grosspay: json["grosspay"],
        netpay: json["netpay"]?.toDouble(),
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        taxFreeTrashHold: json["TaxFreeTrashHold"],
        fortnightlyTax: json["FortnightlyTax"]?.toDouble(),
        medicalLeaveyTax: json["medicalLeaveyTax"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "employeeId": employeeId,
        "totalPayment": totalPayment,
        "currentworkinghours": currentworkinghours,
        "allowances": allowances,
        "extraAmount": extraAmount,
        "grosspay": grosspay,
        "netpay": netpay,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "TaxFreeTrashHold": taxFreeTrashHold,
        "FortnightlyTax": fortnightlyTax,
        "medicalLeaveyTax": medicalLeaveyTax,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
