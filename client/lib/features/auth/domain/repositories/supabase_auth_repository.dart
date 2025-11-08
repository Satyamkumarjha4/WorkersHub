import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseAuthRepository {
  Stream<AuthState> observeAuthState();
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
