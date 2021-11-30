//TODO: this is temporary for now until we implement the login page
class SsoData {
  final String? token;
  final String? expiresAt;
  SsoData({
    required this.token,
    required this.expiresAt,
  });

  factory SsoData.fromJson(dynamic json) {
    final j = json['data'];
    return SsoData(
      token: j['token'] as String?,
      expiresAt: j['expires'] as String?,
    );
  }
}

class SsoDataError {
  final String? message;
  SsoDataError({
    required this.message,
  });

  factory SsoDataError.fromJson(dynamic json) {
    return SsoDataError(
      message: json['message'] as String?,
    );
  }
}
