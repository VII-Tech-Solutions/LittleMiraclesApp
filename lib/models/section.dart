import 'package:flutter/material.dart';

class Section {
  final int? id;
  final String? image;
  final String? title;
  final String? content;
  final int? status;
  final int? type;
  final String? actionText;
  final String? goTo;
  final String? updatedAt;
  final String? deletedAt;
  final bool? isFeatured;

  Section({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.content,
    @required this.status,
    @required this.type,
    @required this.actionText,
    @required this.goTo,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.isFeatured,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'image': image ?? "",
      'title': title ?? "",
      'content': content ?? "",
      'status': status ?? -1,
      'type': type ?? "",
      'actionText': actionText ?? "",
      'goTo': goTo ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'isFeatured': isFeatured == true ? 1 : 0,
    };
  }

  factory Section.fromJson(dynamic json) {
    return Section(
      id: json['id'] as int?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      type: json['type'] as int?,
      actionText: json['action_text'] as String?,
      goTo: json['go_to'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      isFeatured: json['is_featured'] as bool?,
    );
  }
}
