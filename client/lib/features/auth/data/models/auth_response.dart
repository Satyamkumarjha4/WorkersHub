class AuthResponse {
  final String message;
  final Map<String, dynamic>? data;

  const AuthResponse({required this.message, this.data});
  factory AuthResponse.fromJSON(Map<String, dynamic> json) {
    print("json response in auth response: $json");
    print("json data is ${json["message"]} ${json["userData"]}");
    return AuthResponse(message: json["message"]!, data: json["userData"]);
  }
}
