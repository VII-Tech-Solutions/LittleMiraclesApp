import 'package:flutter/foundation.dart';

class Session {
  final int? id;
  final String? title;
  final int? userId;
  final int? familyId;
  final int? packageId;
  final int? subPackageId;
  final String? customBackdrop;
  final String? customCake;
  final String? comments;
  final String? totalPrice;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? date;
  final String? time;
  final bool? includeMe;
  final String? locationText;
  final String? locationLink;
  final bool? isOutdoor;
  final bool? giftClaimed;
  final String? formattedDate;
  final String? formattedPeople;
  final String? formattedBackdrop;
  final String? formattedCake;
  final String? photographerName;
  final bool? hasGuideline;
  final String? benefitsIds;
  final String? reviewsIds;
  final String? mediaIds;
  final String? featuredImage;
  final String? subSessionsIds;

  Session({
    @required this.id,
    @required this.title,
    @required this.userId,
    @required this.familyId,
    @required this.packageId,
    @required this.subPackageId,
    @required this.customBackdrop,
    @required this.customCake,
    @required this.comments,
    @required this.totalPrice,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.date,
    @required this.time,
    @required this.includeMe,
    @required this.locationText,
    @required this.locationLink,
    @required this.isOutdoor,
    @required this.giftClaimed,
    @required this.formattedDate,
    @required this.formattedPeople,
    @required this.formattedBackdrop,
    @required this.formattedCake,
    @required this.photographerName,
    @required this.hasGuideline,
    @required this.benefitsIds,
    @required this.reviewsIds,
    @required this.mediaIds,
    @required this.featuredImage,
    @required this.subSessionsIds,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'userId': userId ?? -1,
      'familyId': familyId ?? -1,
      'packageId': packageId ?? -1,
      'subPackageId': subPackageId ?? -1,
      'customBackdrop': customBackdrop ?? "",
      'customCake': customCake ?? "",
      'comments': comments ?? "",
      'totalPrice': totalPrice ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'date': date ?? "",
      'time': time ?? "",
      'includeMe': includeMe == true ? 1 : 0,
      'locationText': locationText ?? "",
      'locationLink': locationLink ?? "",
      'isOutdoor': isOutdoor == true ? 1 : 0,
      'giftClaimed': giftClaimed == true ? 1 : 0,
      'formattedDate': formattedDate ?? "",
      'formattedPeople': formattedPeople ?? "",
      'formattedBackdrop': formattedBackdrop ?? "",
      'formattedCake': formattedCake ?? "",
      'photographerName': photographerName ?? "",
      'hasGuideline': hasGuideline == true ? 1 : 0,
      'benefitsIds': benefitsIds ?? "",
      'reviewsIds': reviewsIds ?? "",
      'mediaIds': mediaIds ?? "",
      'featuredImage': featuredImage ?? "",
      'subSessionsIds': subSessionsIds ?? "",
    };
  }

  factory Session.fromJson(dynamic json) {
    return Session(
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['user_id'] as int?,
      familyId: json['family_id'] as int?,
      packageId: json['package_id'] as int?,
      subPackageId: json['sub_package_id'] as int?,
      customBackdrop: json['custom_backdrop'] as String?,
      customCake: json['custom_cake'] as String?,
      comments: json['comments'] as String?,
      totalPrice: json['total_price'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      includeMe: json['include_me'] as bool?,
      locationText: json['location_text'] as String?,
      locationLink: json['location_link'] as String?,
      isOutdoor: json['is_outdoor'] as bool?,
      giftClaimed: json['gift_claimed'] as bool?,
      formattedDate: json['formatted_date'] as String?,
      formattedPeople: json['formatted_people'] as String?,
      formattedBackdrop: json['formatted_backdrop'] as String?,
      formattedCake: json['formatted_cake'] as String?,
      photographerName: json['photographer_name'] as String?,
      hasGuideline: json['has_guideline'] as bool?,
      benefitsIds: json['benefits_ids'] as String?,
      reviewsIds: json['reviews_ids'] as String?,
      mediaIds: json['media_ids'] as String?,
      featuredImage: json['featured_image'] as String?,
      subSessionsIds: json['sub_sessions_ids'] as String?,
    );
  }
}
