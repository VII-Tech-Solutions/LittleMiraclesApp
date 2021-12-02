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
    };
  }

  factory Package.fromJson(dynamic json) {
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
    );
  }
}
