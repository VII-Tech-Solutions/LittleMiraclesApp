import 'package:flutter/foundation.dart';

class Gift {
  final int? id;
  final String? image;
  final String? title;
  final String? offer;
  final String? content;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? postedAt;
  final String? validUntil;
  final String? promoCode;
  final int? sessionId;
  final int? packageId;
  final int? userId;
  final int? type;

  Gift({
    required this.id,
    required this.image,
    required this.title,
    required this.offer,
    required this.content,
    required this.status,
    required this.updatedAt,
    required this.deletedAt,
    required this.postedAt,
    required this.validUntil,
    required this.promoCode,
    required this.sessionId,
    required this.packageId,
    required this.userId,
    required this.type,
  });

  factory Gift.fromJson(dynamic json) {
    return Gift(
      id: json['id'] as int?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      offer: json['offer'] as String?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      postedAt: json['posted_at'] as String?,
      validUntil: json['valid_until'] as String?,
      promoCode: json['promo_code'] as String?,
      sessionId: json['session_id'] as int?,
      packageId: json['package_id'] as int?,
      userId: json['user_id'] as int?,
      type: json['type'] as int?,
    );
  }
}
