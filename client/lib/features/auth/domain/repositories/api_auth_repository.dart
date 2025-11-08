import 'package:client/features/auth/data/models/auth_response.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';

abstract class ApiAuthRepository {
  Future<AuthResponse> signInWithGoogle(GoogleAuthModel data);
}
