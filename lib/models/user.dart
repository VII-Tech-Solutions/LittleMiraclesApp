class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? updatedAt;
  final String? deletedAt;
  final int? countryCode;
  final int? gender;
  final String? birthDate;
  final String? avatar;
  final String? pastExperience;
  final int? familyId;
  final int? status;
  final int? chatWithEveryone;
  final String? providerId;
  final String? username;
  final String? provider;
  final String? firebaseId;
  final String? name;
  final role;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      required this.updatedAt,
      required this.deletedAt,
      required this.countryCode,
      required this.gender,
      required this.birthDate,
      required this.avatar,
      required this.pastExperience,
      required this.familyId,
      required this.status,
      required this.providerId,
      required this.username,
      required this.provider,
      required this.firebaseId,
      required this.chatWithEveryone,
      this.name,
      this.role});

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'phoneNumber': phoneNumber ?? "",
      'email': email ?? "",
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
      'countryCode': countryCode ?? "",
      'gender': gender ?? -1,
      'birthDate': birthDate ?? "",
      'avatar': avatar ?? "",
      'pastExperience': pastExperience ?? "",
      'familyId': familyId ?? -1,
      'status': status ?? -1,
      'providerId': providerId ?? "",
      'username': username ?? "",
      'provider': provider ?? "",
      'role': role ?? "",
      'name': name ?? "",
    };
  }

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        phoneNumber: json['phone_number'] as String?,
        email: json['email'] as String?,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as String?,
        countryCode: json['country_code'] as int?,
        gender: json['gender'] as int?,
        birthDate: json['birth_date'] as String?,
        avatar: json['avatar'] as String?,
        pastExperience: json['past_experience'] as String?,
        familyId: json['family_id'] as int?,
        status: json['status'] as int?,
        providerId: json['provider_id'] as String?,
        username: json['username'] as String?,
        provider: json['provider'] as String?,
        firebaseId: json['firebase_id'] as String?,
        chatWithEveryone: json['chat_with_everyone'] as int?,
        role: json['role'],
        name: json['name']);
  }
}
