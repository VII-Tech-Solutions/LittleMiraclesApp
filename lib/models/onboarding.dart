// Flutter imports:
import 'package:flutter/foundation.dart';

class Onboarding {
  final int? id;
  final String? updatedAt;
  final String? deletedAt;
  final String? title;
  final String? content;
  final String? image;
  final int? order;

  Onboarding({
    @required this.id,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.title,
    @required this.content,
    @required this.image,
    @required this.order,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'title': title ?? "",
      'content': content ?? "",
      'image': image ?? "",
      'orderNum': order ?? -1,
    };
  }

  factory Onboarding.fromJson(dynamic json) {
    return Onboarding(
      id: json['id'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      order: json['order'] as int?,
    );
  }
}
