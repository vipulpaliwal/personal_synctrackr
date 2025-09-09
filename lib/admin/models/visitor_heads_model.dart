import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String department;
  final String position;
  final String email;
  final String phone;
  final String avatar;
  final String status;
  final Color statusColor;

  Employee({
    required this.name,
    required this.department,
    required this.position,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.status,
    required this.statusColor,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'] ?? 'Unknown',
      department: json['dept'] ?? 'Unknown',
      position: json['designation'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      avatar: 'assets/images/adminImages/avatar1.png', // Default avatar
      status: json['status'] ?? 'Free',
      statusColor: (json['status'] == 'In Meeting' || json['status'] == 'On Meeting') ? Colors.orange : Colors.green,
    );
  }
}
