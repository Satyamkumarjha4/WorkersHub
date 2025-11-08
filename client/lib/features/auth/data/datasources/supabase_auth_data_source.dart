import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDataSource {
  final SupabaseClient client;
  const SupabaseAuthDataSource(this.client);
  Stream<AuthState> authStateChange() => client.auth.onAuthStateChange;

  Future<void> signInWithGoogle() async {
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.platformDefault,
      redirectTo: "com.client://auth-callback?screen=callback",
    );
  }
}
