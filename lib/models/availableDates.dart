// Flutter imports:
import 'package:flutter/material.dart';

class AvailableDates {
  final String? updatedAt;
  final String? deletedAt;
  final List<dynamic>? timings;
  final String? date;

  AvailableDates({
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.timings,
    @required this.date,
  });

  factory AvailableDates.fromJson(dynamic json) {
    return AvailableDates(
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      timings: json['timings'] as List<dynamic>?,
      date: json['date'] as String?,
    );
  }
}
