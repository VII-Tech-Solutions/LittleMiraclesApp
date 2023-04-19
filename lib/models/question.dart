// Flutter imports:
import 'package:flutter/material.dart';

class Question {
  final int? id;
  final String? question;
  final int? questionType;
  final int? order;
  final String? updatedAt;
  final String? deletedAt;
  final List<OptionsArray>? options;

  Question({
    @required this.id,
    @required this.question,
    @required this.questionType,
    @required this.order,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.options,
  });

  Map toJson() {
    List<Map>? items = this.options != null
        ? this.options!.map((i) => i.toJson()).toList()
        : null;

    return {
      'id': id,
      'question': question,
      'question_type': questionType,
      'order': order,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'items': items,
    };
  }

  factory Question.fromJson(dynamic json) {
    final optionsJson = json['options_array'] as List?;

    return Question(
      id: json['id'] as int?,
      question: json['question'] as String?,
      questionType: json['question_type'] as int?,
      order: json['order'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      options: optionsJson?.map((e) => OptionsArray.fromJson(e)).toList(),
    );
  }
}

class OptionsArray {
  final int? id;
  final String? value;

  OptionsArray({
    this.id,
    this.value,
  });

  Map toJson() {
    return {
      "id": id,
      "value": value,
    };
  }

  factory OptionsArray.fromJson(dynamic json) {
    return OptionsArray(
      id: json['id'] as int?,
      value: json['value'] as String?,
    );
  }
}
