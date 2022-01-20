import 'package:flutter/foundation.dart';

class StudioMetadata {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final int? status;
  final int? category;
  final String? updatedAt;
  final String? deletedAt;

  StudioMetadata({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.status,
    @required this.category,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'description': description ?? "",
      'image': image ?? "",
      'status': status ?? -1,
      'category': category ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory StudioMetadata.fromJson(dynamic json) {
    return StudioMetadata(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      status: json['status'] as int?,
      category: json['category'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}