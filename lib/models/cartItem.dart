import 'package:flutter/material.dart';

class CartItem {
  final int? id;
  final String? title;
  final String? description;
  final String? price;
  final String? image;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image});

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'description': description ?? -1,
      'price': price ?? "",
    };
  }

  factory CartItem.fromJson(dynamic json) {
    return CartItem(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      image: json['image'] as String?,
    );
  }
}
