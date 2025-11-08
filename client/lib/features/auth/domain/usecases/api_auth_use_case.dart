import 'package:client/features/auth/data/models/auth_response.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/features/auth/domain/repositories/api_auth_repository.dart';

class ApiAuthUseCase {
  final ApiAuthRepository _repository;
  ApiAuthUseCase(this._repository);

  Future<AuthResponse> signInWithGoogle(GoogleAuthModel data) async {
    return _repository.signInWithGoogle(data);
  }
}
