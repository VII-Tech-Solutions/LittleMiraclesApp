// Flutter imports:
import 'package:flutter/foundation.dart';

class StudioPackage {
  final int? id;
  final String? title;
  final String? image;
  final String? startingPrice;
  final int? status;
  final int? type;
  final String? benefitIds;
  final String? mediaIds;
  final String? updatedAt;
  final String? deletedAt;

  StudioPackage({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.startingPrice,
    @required this.status,
    @required this.type,
    @required this.benefitIds,
    @required this.mediaIds,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'image': image ?? "",
      'startingPrice': startingPrice ?? "",
      'status': status ?? -1,
      'type': type ?? -1,
      'benefitIds': benefitIds ?? "",
      'mediaIds': mediaIds ?? "",
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory StudioPackage.fromJson(dynamic json) {
    return StudioPackage(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      startingPrice: json['starting_price'] as String?,
      status: json['status'] as int?,
      type: json['type'] as int?,
      benefitIds: json['benefits_ids'] as String?,
      mediaIds: json['media_ids'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
