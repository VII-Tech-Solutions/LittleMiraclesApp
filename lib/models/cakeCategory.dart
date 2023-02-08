// Flutter imports:
import 'package:flutter/material.dart';

class CakeCategory {
  final int? id;
  final String? name;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? image;

  CakeCategory(
      {@required this.id,
      @required this.name,
      @required this.status,
      @required this.updatedAt,
      @required this.deletedAt,
      this.image});

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'name': name ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'image': image ?? ""
    };
  }

  factory CakeCategory.fromJson(dynamic json) {
    return CakeCategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
        status: json['status'] as int?,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as String?,
        image: json['image'] as String?);
  }
}
