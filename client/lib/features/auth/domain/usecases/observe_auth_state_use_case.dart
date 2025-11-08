import 'package:client/features/auth/domain/repositories/supabase_auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ObserveAuthStateUseCase {
  final SupabaseAuthRepository repo;
  ObserveAuthStateUseCase(this.repo);

  Stream<AuthState> check() => repo.observeAuthState();
}
