// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';

class CartItem {
  final int? id;
  final String? title;
  final String? description;
  final String? price;
  final String? displayImage;
  final String? mediaIds;
  // final List<Media>? imageList;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.displayImage,
    // @required this.imageList,
    @required this.mediaIds,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'title': title ?? "",
      'description': description ?? -1,
      'price': price ?? '',
      'displayImage': displayImage ?? '',
      'mediaIds': mediaIds ?? '',
    };
  }

  // factory CartItem.fromJson(dynamic json) {
  //   return CartItem(
  //     id: json['id'] as int?,
  //     title: json['title'] as String?,
  //     description: json['description'] as String?,
  //     price: json['price'] as String,
  //     displayImage: json['image'] as String?,
  //   );
  // }
}
