// To parse this JSON data, do
//
//     final userGiftsResponseModel = userGiftsResponseModelFromJson(jsonString);

import 'dart:convert';

UserGiftsResponseModel userGiftsResponseModelFromJson(String str) =>
    UserGiftsResponseModel.fromJson(json.decode(str));

String userGiftsResponseModelToJson(UserGiftsResponseModel data) =>
    json.encode(data.toJson());

class UserGiftsResponseModel {
  Data data;

  UserGiftsResponseModel({
    required this.data,
  });

  factory UserGiftsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserGiftsResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  List<Gift> gifts;

  Data({
    required this.gifts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gifts: List<Gift>.from(json["gifts"].map((x) => Gift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gifts": List<dynamic>.from(gifts.map((x) => x.toJson())),
      };
}

class Gift {
  int id;
  dynamic image;
  String? title;
  String offer;
  dynamic content;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  DateTime postedAt;
  DateTime validUntil;
  String promoCode;
  dynamic sessionId;
  int packageId;
  int userId;
  int type;
  String to;
  String from;
  String? message;
  String packageImage;
  String? packageTitle;
  String? packageTag;

  Gift({
    required this.id,
    this.image,
    required this.title,
    required this.offer,
    this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.postedAt,
    required this.validUntil,
    required this.promoCode,
    this.sessionId,
    required this.packageId,
    required this.userId,
    required this.type,
    required this.to,
    required this.from,
    this.message,
    required this.packageImage,
    required this.packageTitle,
    required this.packageTag,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        offer: json["offer"],
        content: json["content"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        postedAt: DateTime.parse(json["posted_at"]),
        validUntil: DateTime.parse(json["valid_until"]),
        promoCode: json["promo_code"],
        sessionId: json["session_id"],
        packageId: json["package_id"],
        userId: json["user_id"],
        type: json["type"],
        to: json["to"],
        from: json["from"],
        message: json["message"],
        packageImage: json["package_image"],
        packageTitle: json["package_title"],
        packageTag: json["package_tag"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": titleValues.reverse[title],
        "offer": offer,
        "content": content,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "posted_at": postedAt.toIso8601String(),
        "valid_until": validUntil.toIso8601String(),
        "promo_code": promoCode,
        "session_id": sessionId,
        "package_id": packageId,
        "user_id": userId,
        "type": type,
        "to": to,
        "from": from,
        "message": message,
        "package_image": packageImage,
        "package_title": titleValues.reverse[packageTitle],
        "package_tag": packageTagValues.reverse[packageTag],
      };
}

enum PackageTag {
  PORTRAIT_STUDIO_SESSION,
  STUDIO_OUTDOOR_SESSION,
  FAMILY_PORTRAIT_STUDIO_SESSION,
  NEWBORN_STUDIO_SESSION,
  MONTHLY_PROMOTION,
  THE_4_MEMORABLE_MILESTONE_SESSIONS
}

final packageTagValues = EnumValues({
  "Family Portrait Studio Session": PackageTag.FAMILY_PORTRAIT_STUDIO_SESSION,
  "Monthly Promotion": PackageTag.MONTHLY_PROMOTION,
  "Newborn Studio Session": PackageTag.NEWBORN_STUDIO_SESSION,
  "Portrait Studio Session": PackageTag.PORTRAIT_STUDIO_SESSION,
  "Studio/Outdoor Session": PackageTag.STUDIO_OUTDOOR_SESSION,
  "4 memorable milestone sessions":
      PackageTag.THE_4_MEMORABLE_MILESTONE_SESSIONS
});

enum Title { TWINKLE, SHIMMER, SPARKLE, GLIMMER, MINI_SESSION, BABY_PLAN }

final titleValues = EnumValues({
  "Baby Plan": Title.BABY_PLAN,
  "Glimmer": Title.GLIMMER,
  "Mini Session": Title.MINI_SESSION,
  "Shimmer": Title.SHIMMER,
  "Sparkle": Title.SPARKLE,
  "Twinkle": Title.TWINKLE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
