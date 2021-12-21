import 'package:flutter/foundation.dart';

class Media {
  final int? id;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;
  final String? name;
  final String? url;
  final int? type;
  final int? packageId;
  final int? sessionId;
  final int? familyId;
  final int? userId;

  Media({
    @required this.id,
    @required this.status,
    @required this.updatedAt,
    @required this.deletedAt,
    @required this.name,
    @required this.url,
    @required this.type,
    @required this.packageId,
    @required this.sessionId,
    @required this.familyId,
    @required this.userId,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'name': name ?? "",
      'url': url ?? "",
      'type': type ?? -1,
      'packageId': packageId ?? -1,
      'sessionId': sessionId ?? -1,
      'familyId': familyId ?? -1,
      'userId': userId ?? -1,
    };
  }

  factory Media.fromJson(dynamic json) {
    return Media(
      id: json['id'] as int?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      type: json['type'] as int?,
      packageId: json['package_id'] as int?,
      sessionId: json['session_id'] as int?,
      familyId: json['family_id'] as int?,
      userId: json['user_id'] as int?,
    );
  }
}
