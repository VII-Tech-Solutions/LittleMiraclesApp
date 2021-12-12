import 'package:flutter/material.dart';

class Question {
  final int? id;
  final String? question;
  final int? questionType;
  final int? order;
  final String? updatedAt;
  final String? deletedAt;
  final List<OptionsArray>? items;

  Question({
    @required this.id,
    @required this.question,
    @required this.questionType,
    @required this.order,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.items,
  });

  Map toJson() {
    List<Map>? items =
        this.items != null ? this.items!.map((i) => i.toJson()).toList() : null;

    return {
      'id': id,
      'question': question,
      'questionType': questionType,
      'order': order,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'items': items,
    };
  }

  // factory Question.fromJson(dynamic json) {
  //   return Question(
  //    id,                       id,
  //    question,                 question,
  //    questionType,             questionType,
  //    order,                    order,
  //    updatedAt,                updatedAt,
  //    deletedAt,                deletedAt,
  //    items,                    items,
  //   );
  // }
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
}
