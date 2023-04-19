class FamilyInfo {
  final int? id;
  final int? userId;
  final int? familyId;
  final int? questionId;
  final String? answer;
  final int? status;
  final String? updatedAt;
  final String? deletedAt;

  FamilyInfo({
    required this.id,
    required this.userId,
    required this.familyId,
    required this.questionId,
    required this.answer,
    required this.status,
    required this.updatedAt,
    required this.deletedAt,
  });

  Map<String, Object> toMap() {
    return {
      'id': id ?? -1,
      'userId': userId ?? -1,
      'familyId': familyId ?? -1,
      'questionId': questionId ?? -1,
      'answer': answer ?? "",
      'status': status ?? -1,
      'updatedAt': updatedAt ?? "",
      'deletedAt': deletedAt ?? "",
    };
  }

  factory FamilyInfo.fromJson(dynamic json) {
    return FamilyInfo(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      familyId: json['family_id'] as int?,
      questionId: json['question_id'] as int?,
      answer: json['answer'] as String?,
      status: json['status'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }
}
