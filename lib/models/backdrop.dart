// Flutter imports:
import 'package:flutter/material.dart';

class Backdrop {
  final int? id;
  final String? title;
  final int? categoryId;
  final String? image;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Backdrop({
    @required this.id,
    @required this.title,
    @required this.categoryId,
    @required this.image,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'categoryId': categoryId ?? "",
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
      categoryId: json['category_id'] as int?,
      image: json['image'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
