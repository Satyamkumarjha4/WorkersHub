import 'package:client/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:client/features/auth/domain/repositories/supabase_auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepositoryImplementation extends SupabaseAuthRepository {
  final SupabaseAuthDataSource _dataSource;

  SupabaseAuthRepositoryImplementation(this._dataSource);
  @override
  Stream<AuthState> observeAuthState() {
    return _dataSource.authStateChange().map((state) => state);
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    print("");
  }

  @override
  Future<void> signInWithGoogle() async {
    _dataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    print("");
  }
}
