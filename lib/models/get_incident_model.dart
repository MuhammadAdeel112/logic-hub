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
  final String? imageUrl; // 🔥 Isay Optional (?) kiya kyunke JSON mein null aa raha hai

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
    this.imageUrl, // 🔥 Required hata diya
  });

  factory GetIncidentModel.fromJson(Map<String, dynamic> json) {
    return GetIncidentModel(
      id: json['_id'] ?? '',
      jobId: json['jobId'] ?? '',
      employeeId: json['employeeId'] ?? '',
      clientName: json['clientName'] ?? 'N/A',
      staffName: json['staffName'] ?? 'N/A',
      staffDesignation: json['staffDesignation'] ?? 'N/A',
      location: json['location'] ?? 'N/A',
      description: json['description'] ?? '',
      // 🔥 Date parsing ko safe banaya
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
      type: json['type'] ?? 'Other',
      action: json['action'] ?? 'N/A',
      imageUrl: json['imageUrl'], // Ye ab null handle kar lega
    );
  }
}