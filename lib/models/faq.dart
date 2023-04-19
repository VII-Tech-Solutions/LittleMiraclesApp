// Flutter imports:
import 'package:flutter/material.dart';

class FAQ {
  final int? id;
  final String? question;
  final String? answer;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  FAQ({
    @required this.id,
    @required this.question,
    @required this.answer,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'question': question ?? "",
      'answer': answer ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory FAQ.fromJson(dynamic json) {
    return FAQ(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
