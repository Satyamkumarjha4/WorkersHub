import 'package:client/features/auth/data/models/auth_response.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:dio/dio.dart';

class ApiAuthDataSource {
  final Dio client;
  ApiAuthDataSource(this.client);

  Future<AuthResponse> signInWithGoogle(GoogleAuthModel data) async {
    print("before api calling ${data.name}");
    try {
      if (data.role != null) {
        await client.post(
          "/register/auth/google",
          data: {
            "name": data.name,
            "email": data.email,
            "role": data.role,
            "avatar": data.avatar,
          },
        );
      }
      print(data.email);
      final Response loginResponse = await client.post(
        "/login/auth/google",
        data: {"email": data.email},
      );
      print("login ke baad ka data: ${loginResponse.data}");
      final authResponse = AuthResponse.fromJSON(loginResponse.data);
      print(
        "ye rha auth response ka data: ${authResponse.message} ${authResponse.data}",
      );
      return authResponse;
    } catch (e) {
      print(e);
      return AuthResponse(message: e.toString());
    }
  }
}
