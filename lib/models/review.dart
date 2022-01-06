import 'package:flutter/foundation.dart';

class Review {
  final int? id;
  final double? rating;
  final String? userName;
  final String? userImage;
  final int? userId;
  final int? packageId;
  final int? sessionId;
  final String? comment;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  Review({
    @required this.id,
    @required this.rating,
    @required this.userName,
    @required this.userImage,
    @required this.userId,
    @required this.packageId,
    @required this.sessionId,
    @required this.comment,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'rating': rating ?? -1.0,
      'userName': userName ?? "",
      'userImage': userImage ?? "",
      'userId': userId ?? -1,
      'packageId': packageId ?? -1,
      'sessionId': sessionId ?? -1,
      'comment': comment ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory Review.fromJson(dynamic json) {
    final rate = json['rating'] as String?;
    return Review(
      id: json['id'] as int?,
      rating: rate == null ? 0.0 : double.parse(rate.toString()),
      userName: json['user_name'] as String?,
      userImage: json['user_image'] as String?,
      userId: json['user_id'] as int?,
      packageId: json['package_id'] as int?,
      sessionId: json['session_id'] as int?,
      comment: json['comment'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
