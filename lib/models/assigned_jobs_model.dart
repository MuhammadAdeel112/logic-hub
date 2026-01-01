import 'dart:convert';

AssignedJobsModel assignedJobsModelFromJson(String str) =>
    AssignedJobsModel.fromJson(json.decode(str));

String assignedJobsModelToJson(AssignedJobsModel data) =>
    json.encode(data.toJson());

// =============================================================
// MAIN MODEL
// =============================================================
class AssignedJobsModel {
  List<Job> job;
  int status;

  AssignedJobsModel({required this.job, required this.status});

  factory AssignedJobsModel.fromJson(Map<String, dynamic> json) {
    return AssignedJobsModel(
      job: List<Job>.from((json["job"] ?? []).map((x) => Job.fromJson(x))),
      status: json["status"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "job": List<dynamic>.from(job.map((x) => x.toJson())),
    "status": status,
  };
}

// =============================================================
// JOB MODEL
// =============================================================
class Job {
  String id;
  String title;
  String description;
  List<Task> task;
  DateTime startTime;
  DateTime endTime;
  Address address;
  String extraAmount;
  int extraDistance;
  int allowances;
  num extraHours;
  String approvalStatus;
  String status;
  String shift;

  DateTime? clockin;
  DateTime? clockout;
  String? jobNotes;
  String? managerRemarks;
  String? imageUrl;

  List<Manager> manager;
  Client client; // ✅ single object (not list)

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.task,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.extraAmount,
    required this.extraDistance,
    required this.allowances,
    required this.extraHours,
    required this.approvalStatus,
    required this.status,
    required this.shift,
    this.clockin,
    this.clockout,
    this.jobNotes,
    this.managerRemarks,
    this.imageUrl,
    required this.manager,
    required this.client,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["_id"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    task: List<Task>.from((json["task"] ?? []).map((x) => Task.fromJson(x))),
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    address: Address.fromJson(json["address"]),

    extraAmount: json["extraAmount"] ?? "0",
    extraDistance: json["extraDistance"] ?? 0,
    allowances: json["allowances"] ?? 0,
    extraHours: json["extrahours"] ?? 0,

    approvalStatus: json["approvalStatus"] ?? "",
    status: json["status"] ?? "",
    shift: json["shift"] ?? "",

    clockin: json["clockin"] == null ? null : DateTime.parse(json["clockin"]),
    clockout:
    json["clockout"] == null ? null : DateTime.parse(json["clockout"]),
    jobNotes: json["jobNotes"],
    managerRemarks: json["managerRemarks"],
    imageUrl: json["imageUrl"],

    manager:
    List<Manager>.from((json["manager"] ?? []).map((x) => Manager.fromJson(x))),

    client: Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "task": List<dynamic>.from(task.map((x) => x.toJson())),
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "address": address.toJson(),
    "extraAmount": extraAmount,
    "extraDistance": extraDistance,
    "allowances": allowances,
    "extrahours": extraHours,
    "approvalStatus": approvalStatus,
    "status": status,
    "shift": shift,
    "clockin": clockin?.toIso8601String(),
    "clockout": clockout?.toIso8601String(),
    "jobNotes": jobNotes,
    "managerRemarks": managerRemarks,
    "imageUrl": imageUrl,
    "manager": List<dynamic>.from(manager.map((x) => x.toJson())),
    "client": client.toJson(),
  };
}

// =============================================================
// ADDRESS MODEL
// =============================================================
class Address {
  String formattedAddress;
  double lat;
  double long;

  Address({
    required this.formattedAddress,
    required this.lat,
    required this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    formattedAddress: json["formattedAddress"] ?? "",
    lat: (json["lat"] ?? 0).toDouble(),
    long: (json["long"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "formattedAddress": formattedAddress,
    "lat": lat,
    "long": long,
  };
}

// =============================================================
// CLIENT MODEL (100% From Your API)
// =============================================================
class Client {
  String id;
  String managerId;
  String companyId;

  String firstName;
  String middleName;
  String lastName;

  DateTime dob;
  String mobile;
  String email;
  String password;

  String primaryLanguage;
  bool requiresInterpreter;

  Address address;

  String ndisNumber;
  String planManagementType;

  List<EmergencyContact> emergencyContact;
  GpDetails gpDetails;

  List<String> diagnosis;
  List<String> allergies;
  List<String> preferredCommunicationMethod;

  String livingArrangement;
  String goalsAndSupportNeeds;

  RiskAssessment riskAssessment;

  String profileImage;
  String medicareNumber;
  String medicareExpiry;
  String pensionNumber;
  String pensionType;
  String pensionExpiry;

  List<SupportingAgency> supportingAgencies;

  String formCompletedBy;
  DateTime completionDate;
  List<String> pronouns;

  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Client({
    required this.id,
    required this.managerId,
    required this.companyId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.mobile,
    required this.email,
    required this.password,
    required this.primaryLanguage,
    required this.requiresInterpreter,
    required this.address,
    required this.ndisNumber,
    required this.planManagementType,
    required this.emergencyContact,
    required this.gpDetails,
    required this.diagnosis,
    required this.allergies,
    required this.preferredCommunicationMethod,
    required this.livingArrangement,
    required this.goalsAndSupportNeeds,
    required this.riskAssessment,
    required this.profileImage,
    required this.medicareNumber,
    required this.medicareExpiry,
    required this.pensionNumber,
    required this.pensionType,
    required this.pensionExpiry,
    required this.supportingAgencies,
    required this.formCompletedBy,
    required this.completionDate,
    required this.pronouns,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["_id"] ?? "",
    managerId: json["managerId"] ?? "",
    companyId: json["companyId"] ?? "",
    firstName: json["firstName"] ?? "",
    middleName: json["middleName"] ?? "",
    lastName: json["lastName"] ?? "",
    dob: DateTime.parse(json["dob"]),
    mobile: json["mobile"] ?? "",
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    primaryLanguage: json["primaryLanguage"] ?? "",
    requiresInterpreter: json["requiresInterpreter"] ?? false,
    address: Address.fromJson(json["address"]),
    ndisNumber: json["ndisNumber"] ?? "",
    planManagementType: json["planManagementType"] ?? "",

    emergencyContact: List<EmergencyContact>.from(
      (json["emergencyContact"] ?? [])
          .map((x) => EmergencyContact.fromJson(x)),
    ),

    gpDetails: GpDetails.fromJson(json["gpDetails"]),

    diagnosis:
    List<String>.from((json["diagnosis"] ?? []).map((x) => x.toString())),
    allergies:
    List<String>.from((json["allergies"] ?? []).map((x) => x.toString())),
    preferredCommunicationMethod: List<String>.from(
        (json["preferredCommunicationMethod"] ?? [])
            .map((x) => x.toString())),

    livingArrangement: json["livingArrangement"] ?? "",
    goalsAndSupportNeeds: json["goalsAndSupportNeeds"] ?? "",

    riskAssessment: RiskAssessment.fromJson(json["riskAssessment"]),

    profileImage: json["profileImage"] ?? "",
    medicareNumber: json["medicareNumber"] ?? "",
    medicareExpiry: json["medicareExpiry"] ?? "",
    pensionNumber: json["pensionNumber"] ?? "",
    pensionType: json["pensionType"] ?? "",
    pensionExpiry: json["pensionExpiry"] ?? "",

    supportingAgencies: List<SupportingAgency>.from(
      (json["supportingAgencies"] ?? [])
          .map((x) => SupportingAgency.fromJson(x)),
    ),

    formCompletedBy: json["formCompletedBy"] ?? "",
    completionDate: DateTime.parse(json["completionDate"]),
    pronouns:
    List<String>.from((json["pronouns"] ?? []).map((x) => x.toString())),

    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "companyId": companyId,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "dob": dob.toIso8601String(),
    "mobile": mobile,
    "email": email,
    "password": password,
    "primaryLanguage": primaryLanguage,
    "requiresInterpreter": requiresInterpreter,
    "address": address.toJson(),
    "ndisNumber": ndisNumber,
    "planManagementType": planManagementType,
    "emergencyContact":
    List<dynamic>.from(emergencyContact.map((x) => x.toJson())),
    "gpDetails": gpDetails.toJson(),
    "diagnosis": diagnosis,
    "allergies": allergies,
    "preferredCommunicationMethod": preferredCommunicationMethod,
    "livingArrangement": livingArrangement,
    "goalsAndSupportNeeds": goalsAndSupportNeeds,
    "riskAssessment": riskAssessment.toJson(),
    "profileImage": profileImage,
    "medicareNumber": medicareNumber,
    "medicareExpiry": medicareExpiry,
    "pensionNumber": pensionNumber,
    "pensionType": pensionType,
    "pensionExpiry": pensionExpiry,
    "supportingAgencies":
    List<dynamic>.from(supportingAgencies.map((x) => x.toJson())),
    "formCompletedBy": formCompletedBy,
    "completionDate": completionDate.toIso8601String(),
    "pronouns": pronouns,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

// =============================================================
// SUPPORTING MODELS
// =============================================================
class EmergencyContact {
  String name;
  String relationship;
  String mobile;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.mobile,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        name: json["name"] ?? "",
        relationship: json["relationship"] ?? "",
        mobile: json["mobile"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "relationship": relationship,
    "mobile": mobile,
  };
}

class GpDetails {
  String name;
  String phone;
  String email;
  String practiceAddress;
  String practiceName;

  GpDetails({
    required this.name,
    required this.phone,
    required this.email,
    required this.practiceAddress,
    required this.practiceName,
  });

  factory GpDetails.fromJson(Map<String, dynamic> json) => GpDetails(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    practiceAddress: json["practiceAddress"] ?? "",
    practiceName: json["practiceName"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "practiceAddress": practiceAddress,
    "practiceName": practiceName,
  };
}

class RiskAssessment {
  String aggressionOrViolence;
  String wanderingOrAbsconding;
  String mentalHealthConcerns;

  RiskAssessment({
    required this.aggressionOrViolence,
    required this.wanderingOrAbsconding,
    required this.mentalHealthConcerns,
  });

  factory RiskAssessment.fromJson(Map<String, dynamic> json) => RiskAssessment(
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

class SupportingAgency {
  String companyName;
  String workerName;
  String phoneNumber;

  SupportingAgency({
    required this.companyName,
    required this.workerName,
    required this.phoneNumber,
  });

  factory SupportingAgency.fromJson(Map<String, dynamic> json) =>
      SupportingAgency(
        companyName: json["companyName"] ?? "",
        workerName: json["workerName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "workerName": workerName,
    "phoneNumber": phoneNumber,
  };
}

// =============================================================
// MANAGER MODEL
// =============================================================
class Manager {
  String id;
  String name;
  String phone;

  Manager({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
  };
}

// =============================================================
// TASK MODEL
// =============================================================
class Task {
  String title;
  bool status;
  String id;

  Task({
    required this.title,
    required this.status,
    required this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
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
