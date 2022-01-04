import 'package:flutter/material.dart';

class Promotion {
  final int? id;
  final String? image;
  final String? title;
  final String? offer;
  final int? type;
  final String? content;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? postedAt;
  final String? validUntil;
  final String? promoCode;

  Promotion({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.offer,
    @required this.type,
    @required this.content,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.postedAt,
    @required this.validUntil,
    @required this.promoCode,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'image': image ?? "",
      'title': title ?? "",
      'offer': offer ?? "",
      'type': type ?? -1,
      'content': content ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'postedAt': postedAt ?? "",
      'validUntil': validUntil ?? "",
      'promoCode': promoCode ?? "",
    };
  }

  factory Promotion.fromJson(dynamic json) {
    return Promotion(
      id: json['id'] as int?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      offer: json['offer'] as String?,
      type: json['type'] as int?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      postedAt: json['posted_at'] as String?,
      validUntil: json['valid_until'] as String?,
      promoCode: json['promo_code'] as String?,
    );
  }
}
