import 'package:intl/intl.dart';

class Visitor {
  final int id;
  final String name;
  final String? company;
  final String purpose;
  final String? profession;
  final String? phone;
  final String? email;
  final String status;
  final DateTime? signedIn;
  final DateTime? signedOut;
  final DateTime appointmentDate;
  final DateTime createdAt;
  final String? photo;
  final IdProof? idProof;
  final String? ePassQR;
  final Consent? consent;
  final Host? host;

  Visitor({
    required this.id,
    required this.name,
    this.company,
    required this.purpose,
    this.profession,
    this.phone,
    this.email,
    required this.status,
    this.signedIn,
    this.signedOut,
    required this.appointmentDate,
    required this.createdAt,
    this.photo,
    this.idProof,
    this.ePassQR,
    this.consent,
    this.host,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'],
      name: json['name'],
      company: json['company'],
      purpose: json['purpose'],
      profession: json['profession'],
      phone: json['phone'],
      email: json['email'],
      status: json['status'] ?? 'pending',
      signedIn:
          json['signedIn'] != null ? DateTime.parse(json['signedIn']) : null,
      signedOut:
          json['signedOut'] != null ? DateTime.parse(json['signedOut']) : null,
      appointmentDate: DateTime.parse(json['appointmentDate']),
      createdAt: DateTime.parse(json['createdAt']),
      photo: json['photo'],
      idProof:
          json['idProof'] != null ? IdProof.fromJson(json['idProof']) : null,
      ePassQR: json['ePassQR'],
      consent:
          json['consent'] != null ? Consent.fromJson(json['consent']) : null,
      host: json['host'] != null ? Host.fromJson(json['host']) : null,
    );
  }
}

class IdProof {
  final String? type;
  final String? number;
  final String? image;

  IdProof({this.type, this.number, this.image});

  factory IdProof.fromJson(Map<String, dynamic> json) {
    return IdProof(
      type: json['type'],
      number: json['number'],
      image: json['image'],
    );
  }
}

class Consent {
  final String? signature;

  Consent({this.signature});

  factory Consent.fromJson(Map<String, dynamic> json) {
    return Consent(
      signature: json['signature'],
    );
  }
}

class Host {
  final int id;
  final String name;
  final String email;
  final String? dept;

  Host({
    required this.id,
    required this.name,
    required this.email,
    this.dept,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      dept: json['dept'],
    );
  }
}

class PendingVisitor {
  final int id;
  final String name;
  final String? company;
  final String purpose;
  final DateTime createdAt;
  final String status;
  final DateTime meetingTime;
  final String? photo;
  final Host? host;

  PendingVisitor({
    required this.id,
    required this.name,
    this.company,
    required this.purpose,
    required this.createdAt,
    required this.status,
    required this.meetingTime,
    this.photo,
    this.host,
  });

  factory PendingVisitor.fromJson(Map<String, dynamic> json) {
    return PendingVisitor(
      id: json['id'],
      name: json['name'],
      company: json['company'],
      purpose: json['purpose'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      meetingTime: DateTime.parse(json['meetingTime']),
      photo: json['photo'],
      host: json['host'] != null ? Host.fromJson(json['host']) : null,
    );
  }

  // Helper getters to match the old widget structure
  String get meetingWith => host?.name ?? 'N/A';
  String get time => DateFormat.jm().format(meetingTime);
  bool get isApproved => status.toLowerCase() == 'approved';
}
