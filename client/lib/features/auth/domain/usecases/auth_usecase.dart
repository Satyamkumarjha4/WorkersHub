import 'package:client/features/auth/domain/repositories/supabase_auth_repository.dart';

class AuthUseCase {
  final SupabaseAuthRepository _repository;

  AuthUseCase(this._repository);

  Future<void> signInWithGoogle() async {
    await _repository.signInWithGoogle();
  }
}
