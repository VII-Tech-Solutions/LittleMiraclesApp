import 'package:flutter/material.dart';

class Backdrop {
  final int? id;
  final String? title;
  final String? category;
  final String? image;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Backdrop({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.image,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'category': category ?? "",
      'image': image ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory Backdrop.fromJson(dynamic json) {
    return Backdrop(
      id: json['id'] as int?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
