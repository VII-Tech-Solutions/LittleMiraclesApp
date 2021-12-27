import 'package:flutter/foundation.dart';

class StudioPackage {
  final int? id;
  final String? title;
  final String? image;
  final String? startingPrice;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  StudioPackage({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.startingPrice,
    @required this.status,
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
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
