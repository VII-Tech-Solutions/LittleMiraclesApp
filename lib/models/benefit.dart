import 'package:flutter/material.dart';

class Benefit {
  final int? id;
  final String? icon;
  final String? title;
  final String? description;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Benefit({
    @required this.id,
    @required this.icon,
    @required this.title,
    @required this.description,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'icon': icon ?? "",
      'title': title ?? "",
      'description': description ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory Benefit.fromJson(dynamic json) {
    return Benefit(
      id: json['id'] as int?,
      icon: json['icon'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
