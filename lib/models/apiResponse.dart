import 'package:flutter/foundation.dart';

class ApiResponse {
  final int? statusCode;
  final String? message;

  ApiResponse({
    @required this.statusCode,
    @required this.message
  });
}