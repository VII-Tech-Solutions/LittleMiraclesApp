class FamilyMember {
  final int? id;
  final int? familyId;
  final String? firstName;
  final String? lastName;
  final int? gender;
  final String? birthDate;
  final int? relationship;
  final int? status;
  final String? phoneNumber;
  final int? countryCode;
  final String? personality;
  final String? updatedAt;
  final String? deletedAt;
  FamilyMember({
    required this.id,
    required this.familyId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.relationship,
    required this.status,
    required this.phoneNumber,
    required this.countryCode,
    required this.personality,
    required this.updatedAt,
    required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'familyId': familyId ?? -1,
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'gender': gender ?? -1,
      'birthDate': birthDate ?? "",
      'relationship': relationship ?? -1,
      'status': status ?? -1,
      'phoneNumber': phoneNumber ?? -1,
      'countryCode': countryCode ?? -1,
      'personality': personality ?? "",
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory FamilyMember.fromJson(dynamic json) {
    return FamilyMember(
      id: json['id'] as int?,
      familyId: json['family_id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      gender: json['gender'] as int?,
      birthDate: json['birth_date'] as String?,
      relationship: json['relationship'] as int?,
      status: json['status'] as int?,
      phoneNumber: json['phone_number'] as String?,
      countryCode: json['country_code'] as int?,
      personality: json['personality'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
