import 'package:flutter/material.dart';

class DailyTip {
  final int? id;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? image;
  final String? title;
  final String? postedAt;
  final String? content;

  DailyTip({
    @required this.id,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.image,
    @required this.title,
    @required this.postedAt,
    @required this.content,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'image': image ?? "",
      'title': title ?? "",
      'postedAt': postedAt ?? "",
      'content': content ?? "",
    };
  }

  factory DailyTip.fromJson(dynamic json) {
    return DailyTip(
      id: json['id'] as int?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      postedAt: json['posted_at'] as String?,
      content: json['content'] as String?,
    );
  }
}
