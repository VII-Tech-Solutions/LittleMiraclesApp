import 'package:flutter/foundation.dart';

class Session {
  final int? id;
  final String? title;
  final int? userId;
  final int? familyId;
  final int? packageId;
  final String? customBackdrop;
  final String? customCake;
  final String? comments;
  final String? totalPrice;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final int? includeMe;
  final String? benefitsIds;
  final String? reviewsIds;
  final String? mediaIds;

  Session({
    @required this.id,
    @required this.title,
    @required this.userId,
    @required this.familyId,
    @required this.packageId,
    @required this.customBackdrop,
    @required this.customCake,
    @required this.comments,
    @required this.totalPrice,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.includeMe,
    @required this.benefitsIds,
    @required this.reviewsIds,
    @required this.mediaIds,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'userId': userId ?? -1,
      'familyId': familyId ?? -1,
      'packageId': packageId ?? -1,
      'customBackdrop': customBackdrop ?? "",
      'customCake': customCake ?? "",
      'comments': comments ?? "",
      'totalPrice': totalPrice ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'includeMe': includeMe ?? -1,
      'benefitsIds': benefitsIds ?? "",
      'reviewsIds': reviewsIds ?? "",
      'mediaIds': mediaIds ?? "",
    };
  }

  factory Session.fromJson(dynamic json) {
    return Session(
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['user_id'] as int?,
      familyId: json['family_id'] as int?,
      packageId: json['package_id'] as int?,
      customBackdrop: json['custom_backdrop'] as String?,
      customCake: json['custom_cake'] as String?,
      comments: json['omments'] as String?,
      totalPrice: json['total_price'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      includeMe: json['include_me'] as int?,
      benefitsIds: json['benefitsIds'] as String?,
      reviewsIds: json['eviewsIds'] as String?,
      mediaIds: json['mediaIds'] as String?,
    );
  }
}
