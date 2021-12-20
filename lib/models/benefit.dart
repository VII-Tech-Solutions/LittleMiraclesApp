import 'package:flutter/material.dart';

class Benefit {
  final int? id;
  final String? icon;
  final String? title;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Benefit({
    @required this.id,
    @required this.icon,
    @required this.title,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'icon': icon ?? "",
      'title': title ?? "",
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
      status: json['status'] as int?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }
}
