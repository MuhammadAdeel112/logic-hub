
class GetIncidentModel {
  final String id;
  final String jobId;
  final String employeeId;
  final String clientName;
  final String staffName;
  final String staffDesignation;
  final String location;
  final String description;
  final DateTime time;
  final String type;
  final String action;
  final String imageUrl;

  GetIncidentModel({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.clientName,
    required this.staffName,
    required this.staffDesignation,
    required this.location,
    required this.description,
    required this.time,
    required this.type,
    required this.action,
    required this.imageUrl,
  });

  factory GetIncidentModel.fromJson(Map<String, dynamic> json) {
    return GetIncidentModel(
      id: json['_id'],
      jobId: json['jobId'],
      employeeId: json['employeeId'],
      clientName: json['clientName'],
      staffName: json['staffName'],
      staffDesignation: json['staffDesignation'],
      location: json['location'],
      description: json['description'],
      time: DateTime.parse(json['time']),
      type: json['type'],
      action: json['action'],
      imageUrl: json['imageUrl'],
    );
  }
}
