// Flutter imports:
import 'package:flutter/material.dart';

class Package {
  final int? id;
  final String? image;
  final String? title;
  final String? tag;
  final String? price;
  final bool? isPopular;
  final int? type;
  final String? content;
  final String? locationText;
  final String? locationLink;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final int? backdropAllowed;
  final int? cakeAllowed;
  final bool? outdoorAllowed;
  final bool? hasGuideline;
  final String? benefitsIds;
  final String? subPackagesIds;
  final String? reviewsIds;
  final String? mediaIds;
  final int? totalReviews;
  final double? rating;
  var additionalCharge;

  Package(
      {@required this.id,
      @required this.image,
      @required this.title,
      @required this.tag,
      @required this.price,
      @required this.isPopular,
      @required this.type,
      @required this.content,
      @required this.locationText,
      @required this.locationLink,
      @required this.status,
      @required this.updatedAt,
      @required this.deletedAt,
      @required this.backdropAllowed,
      @required this.cakeAllowed,
      @required this.benefitsIds,
      @required this.outdoorAllowed,
      @required this.hasGuideline,
      @required this.subPackagesIds,
      @required this.reviewsIds,
      @required this.mediaIds,
      @required this.totalReviews,
      @required this.rating,
      this.additionalCharge = 0});

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'image': image ?? "",
      'title': title ?? "",
      'tag': tag ?? "",
      'price': price ?? "",
      'isPopular': isPopular == true ? 1 : 0,
      'type': type ?? -1,
      'content': content ?? "",
      'locationText': locationText ?? "",
      'locationLink': locationLink ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'backdropAllowed': backdropAllowed ?? -1,
      'cakeAllowed': cakeAllowed ?? -1,
      'benefitsIds': benefitsIds ?? "",
      'outdoorAllowed': outdoorAllowed == true ? 1 : 0,
      'hasGuideline': hasGuideline == true ? 1 : 0,
      'subPackagesIds': subPackagesIds ?? "",
      'reviewsIds': reviewsIds ?? "",
      'mediaIds': mediaIds ?? "",
      'totalReviews': totalReviews ?? -1,
      'rating': rating ?? -1.0,
    };
  }

  factory Package.fromJson(dynamic json) {
    final rate = json['rating'] as String?;
    return Package(
      id: json['id'] as int?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      tag: json['tag'] as String?,
      price: json['price'] as String?,
      isPopular: json['is_popular'] as bool?,
      type: json['type'] as int?,
      content: json['content'] as String?,
      locationText: json['location_text'] as String?,
      locationLink: json['location_link'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      backdropAllowed: json['backdrop_allowed'] as int?,
      cakeAllowed: json['cake_allowed'] as int?,
      outdoorAllowed: json['outdoor_allowed'] as bool?,
      hasGuideline: json['has_guideline'] as bool?,
      benefitsIds: json['benefits_ids'] as String?,
      subPackagesIds: json['sub_packages_ids'] as String?,
      reviewsIds: json['reviews_ids'] as String?,
      mediaIds: json['media_ids'] as String?,
      totalReviews: json['total_reviews'] as int?,
      rating: double.parse(rate.toString()),
    );
  }
}

class SubPackage {
  final int? id;
  final String? title;
  final String? description;
  final int? backdropAllowed;
  final int? cakeAllowed;

  SubPackage({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.backdropAllowed,
    @required this.cakeAllowed,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'description': description ?? "",
      'backdropAllowed': backdropAllowed ?? -1,
      'cakeAllowed': cakeAllowed ?? -1,
    };
  }

  factory SubPackage.fromJson(dynamic json) {
    return SubPackage(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      backdropAllowed: json['backdrop_allowed'] as int?,
      cakeAllowed: json['cake_allowed'] as int?,
    );
  }
}
