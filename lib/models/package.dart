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
  final String? benefitsIds;
  final String? reviewsIds;
  final String? mediaIds;
  final int? totalReviews;
  final double? rating;

  Package({
    @required this.id,
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
    @required this.benefitsIds,
    @required this.reviewsIds,
    @required this.mediaIds,
    @required this.totalReviews,
    @required this.rating,
  });

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
      'benefitsIds': benefitsIds ?? "",
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
      benefitsIds: json['benefits_ids'] as String?,
      reviewsIds: json['reviews_ids'] as String?,
      mediaIds: json['media_ids'] as String?,
      totalReviews: json['total_reviews'] as int?,
      rating: double.parse(rate.toString()) ,
    );
  }
}
