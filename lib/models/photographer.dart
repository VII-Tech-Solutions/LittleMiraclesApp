// Flutter imports:
import 'package:flutter/material.dart';

class Photographer {
  final int? id;
  final String? name;
  final String? image;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Photographer({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'name': name ?? "",
      'image': image ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory Photographer.fromJson(dynamic json) {
    return Photographer(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
