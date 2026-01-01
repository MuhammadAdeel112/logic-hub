import 'dart:convert';

AvailableJobsModel availableJobsModelFromJson(String str) =>
    AvailableJobsModel.fromJson(json.decode(str));

String availableJobsModelToJson(AvailableJobsModel data) =>
    json.encode(data.toJson());

class AvailableJobsModel {
  final List<Jobs> jobs;
  final int status;

  AvailableJobsModel({
    required this.jobs,
    required this.status,
  });

  factory AvailableJobsModel.fromJson(Map<String, dynamic> json) =>
      AvailableJobsModel(
        jobs: List<Jobs>.from(
            (json["jobs"] as List? ?? []).map((x) => Jobs.fromJson(x))),
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
    "status": status,
  };
}

class Jobs {
  final String id;
  final String title;
  final String description;
  final List<Tasks> task;
  final DateTime startTime;
  final DateTime endTime;
  final Address address;
  final dynamic allowances;
  final String approvalStatus;
  final String status;
  final String shift;
  final Clients client;
  final List<Manager> manager;

  Jobs({
    required this.id,
    required this.title,
    required this.description,
    required this.task,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.allowances,
    required this.approvalStatus,
    required this.status,
    required this.shift,
    required this.client,
    required this.manager,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
    id: json["_id"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    task: List<Tasks>.from(
        (json["task"] as List? ?? []).map((x) => Tasks.fromJson(x))),
    startTime: DateTime.tryParse(json["startTime"] ?? "") ??
        DateTime.now(), // safe parse
    endTime: DateTime.tryParse(json["endTime"] ?? "") ?? DateTime.now(),
    address: Address.fromJson(json["address"] ?? {}),
    allowances: json["allowances"],
    approvalStatus: json["approvalStatus"] ?? "",
    status: json["status"] ?? "",
    shift: json["shift"] ?? "",
    client: Clients.fromJson(json["client"] ?? {}),
    manager: List<Manager>.from(
        (json["manager"] as List? ?? []).map((x) => Manager.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "task": List<dynamic>.from(task.map((x) => x.toJson())),
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "address": address.toJson(),
    "allowances": allowances,
    "approvalStatus": approvalStatus,
    "status": status,
    "shift": shift,
    "client": client.toJson(),
    "manager": List<dynamic>.from(manager.map((x) => x.toJson())),
  };
}

class Address {
  final String formattedAddress;
  final double lat;
  final double long;

  Address({
    required this.formattedAddress,
    required this.lat,
    required this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    formattedAddress: json["formattedAddress"] ?? "",
    lat: (json["lat"] as num?)?.toDouble() ?? 0.0,
    long: (json["long"] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "formattedAddress": formattedAddress,
    "lat": lat,
    "long": long,
  };
}

class RiskAssessment {
  final String aggressionOrViolence;
  final String wanderingOrAbsconding;
  final String mentalHealthConcerns;

  RiskAssessment({
    required this.aggressionOrViolence,
    required this.wanderingOrAbsconding,
    required this.mentalHealthConcerns,
  });

  factory RiskAssessment.fromJson(Map<String, dynamic> json) =>
      RiskAssessment(
        aggressionOrViolence: json["aggressionOrViolence"] ?? "",
        wanderingOrAbsconding: json["wanderingOrAbsconding"] ?? "",
        mentalHealthConcerns: json["mentalHealthConcerns"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "aggressionOrViolence": aggressionOrViolence,
    "wanderingOrAbsconding": wanderingOrAbsconding,
    "mentalHealthConcerns": mentalHealthConcerns,
  };
}

class Clients {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String dob;
  final String mobile;
  final String email;
  final String primaryLanguage;
  final bool requiresInterpreter;
  final Address address;

  final String ndisNumber;
  final String planManagementType;
  final String profileImage;
  final String medicareNumber;
  final String medicareExpiry;
  final String pensionNumber;
  final String pensionType;
  final String pensionExpiry;
  final String livingArrangement;
  final String goalsAndSupportNeeds;

  final List<String> diagnosis;
  final List<String> allergies;
  final List<String> preferredCommunicationMethod;
  final List<String> pronouns;

  final RiskAssessment riskAssessment;

  Clients({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.mobile,
    required this.email,
    required this.primaryLanguage,
    required this.requiresInterpreter,
    required this.address,
    required this.ndisNumber,
    required this.planManagementType,
    required this.profileImage,
    required this.medicareNumber,
    required this.medicareExpiry,
    required this.pensionNumber,
    required this.pensionType,
    required this.pensionExpiry,
    required this.livingArrangement,
    required this.goalsAndSupportNeeds,
    required this.diagnosis,
    required this.allergies,
    required this.preferredCommunicationMethod,
    required this.pronouns,
    required this.riskAssessment,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
    id: json["_id"] ??
        json["id"] ??
        json["clientId"] ??
        json["client_id"] ??
        "",
    firstName: json["firstName"] ?? "",
    middleName: json["middleName"] ?? "",
    lastName: json["lastName"] ?? "",
    dob: json["dob"] ?? "",
    mobile: json["mobile"] ?? "",
    email: json["email"] ?? "",
    primaryLanguage: json["primaryLanguage"] ?? "",
    requiresInterpreter: json["requiresInterpreter"] ?? false,
    address: Address.fromJson(json["address"] ?? {}),
    ndisNumber: json["ndisNumber"] ?? "",
    planManagementType: json["planManagementType"] ?? "",
    profileImage: json["profileImage"] ?? "",
    medicareNumber: json["medicareNumber"] ?? "",
    medicareExpiry: json["medicareExpiry"] ?? "",
    pensionNumber: json["pensionNumber"] ?? "",
    pensionType: json["pensionType"] ?? "",
    pensionExpiry: json["pensionExpiry"] ?? "",
    livingArrangement: json["livingArrangement"] ?? "",
    goalsAndSupportNeeds: json["goalsAndSupportNeeds"] ?? "",
    diagnosis: List<String>.from(json["diagnosis"] ?? []),
    allergies: List<String>.from(json["allergies"] ?? []),
    preferredCommunicationMethod:
    List<String>.from(json["preferredCommunicationMethod"] ?? []),
    pronouns: List<String>.from(json["pronouns"] ?? []),
    riskAssessment: RiskAssessment.fromJson(json["riskAssessment"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "dob": dob,
    "mobile": mobile,
    "email": email,
    "primaryLanguage": primaryLanguage,
    "requiresInterpreter": requiresInterpreter,
    "address": address.toJson(),
    "ndisNumber": ndisNumber,
    "planManagementType": planManagementType,
    "profileImage": profileImage,
    "medicareNumber": medicareNumber,
    "medicareExpiry": medicareExpiry,
    "pensionNumber": pensionNumber,
    "pensionType": pensionType,
    "pensionExpiry": pensionExpiry,
    "livingArrangement": livingArrangement,
    "goalsAndSupportNeeds": goalsAndSupportNeeds,
    "diagnosis": diagnosis,
    "allergies": allergies,
    "preferredCommunicationMethod": preferredCommunicationMethod,
    "pronouns": pronouns,
    "riskAssessment": riskAssessment.toJson(),
  };
}

class Manager {
  final String name;
  final String phone;

  Manager({
    required this.name,
    required this.phone,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}

class Tasks {
  final String title;
  final bool status;
  final String id;

  Tasks({
    required this.title,
    required this.status,
    required this.id,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
    title: json["title"] ?? "",
    status: json["status"] ?? false,
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "status": status,
    "_id": id,
  };
}
