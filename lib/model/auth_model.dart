class AuthModel {
  final String email;
  final String password;

  AuthModel(this.email, this.password);

  Map<String, dynamic> toMap() => {'email': email, 'password': password};
}

class AuthResponseModel {
  AuthResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });

  final int status;
  final String message;
  final AuthResponseData? data;
  final String token;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      data:
          json["data"] == null ? null : AuthResponseData.fromJson(json["data"]),
      token: json["token"] ?? "",
    );
  }
}

class AuthResponseData {
  AuthResponseData({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory AuthResponseData.fromJson(Map<String, dynamic> json) {
    return AuthResponseData(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }
}
