// Flutter imports:
import 'package:flutter/material.dart';

class Workshop {
  final int? id;
  final String? image;
  final String? title;
  final String? price;
  final String? content;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? postedAt;

  Workshop({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.price,
    @required this.content,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.postedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'image': image ?? "",
      'title': title ?? "",
      'price': price ?? "",
      'content': content ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'postedAt': postedAt ?? "",
    };
  }

  factory Workshop.fromJson(dynamic json) {
    return Workshop(
      id: json['id'] as int?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      price: json['price'] as String?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      postedAt: json['posted_at'] as String?,
    );
  }
}
