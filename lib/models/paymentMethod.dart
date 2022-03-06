// Flutter imports:
import 'package:flutter/material.dart';

class PaymentMethod {
  final int? id;
  final String? title;

  PaymentMethod({
    @required this.id,
    @required this.title,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
    };
  }

  factory PaymentMethod.fromJson(dynamic json) {
    return PaymentMethod(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );
  }
}
