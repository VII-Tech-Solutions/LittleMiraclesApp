// Flutter imports:
import 'package:flutter/material.dart';

class PromoCode {
  final String? code;
  final String? message;
  final String? originalPrice;
  final String? discountPrice;
  final String? totalPrice;
  final String? subTotalPrice;
  final String? vatAmount;

  String? codepromo;

  PromoCode(
      {@required this.code,
      @required this.message,
      @required this.originalPrice,
      @required this.discountPrice,
      @required this.totalPrice,
      this.subTotalPrice,
      this.vatAmount,
      this.codepromo});

  factory PromoCode.fromJson(dynamic json, String code) {
    final message = json['message'];
    final data = json['data'];
    return PromoCode(
      code: code,
      message: message as String?,
      originalPrice: data['original_price'] as String?,
      discountPrice: data['discount_price'] as String?,
      totalPrice: data['total_price'] as String?,
      subTotalPrice: data['subtotal'] as String?,
      vatAmount: data['vat_amount'] as String?,
    );
  }
}
