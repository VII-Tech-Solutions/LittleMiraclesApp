// Flutter imports:
import 'package:flutter/foundation.dart';

class StudioMetadata {
  final int? id;
  final String? title;
  final String? price;
  final String? description;
  final String? image;
  final int? status;
  final int? category;
  final String? updatedAt;
  final String? deletedAt;
  final int? thicknessId;

  StudioMetadata({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.image,
    @required this.status,
    @required this.category,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.thicknessId,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'price': price ?? "",
      'description': description ?? "",
      'image': image ?? "",
      'status': status ?? -1,
      'category': category ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'thickness_id': thicknessId ?? -1,
    };
  }

  factory StudioMetadata.fromJson(dynamic json) {
    return StudioMetadata(
        id: json['id'] as int?,
        title: json['title'] as String?,
        price: json['price'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        status: json['status'] as int?,
        category: json['category'] as int?,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as String?,
        thicknessId: json['thickness_id'] as int?,);
  }
}
