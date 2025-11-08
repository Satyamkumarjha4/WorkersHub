import 'dart:async';

import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/features/auth/domain/providers.dart';
import 'package:client/features/auth/domain/usecases/api_auth_use_case.dart';
import 'package:client/features/auth/domain/usecases/auth_usecase.dart';
import 'package:client/features/auth/domain/usecases/observe_auth_state_use_case.dart';
import 'package:client/features/auth/presentation/screens/callback_screen.dart';
import 'package:client/features/intro/presentation/providers.dart';
import 'package:client/main.dart';
import 'package:client/models/user_model.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppAuthState {
  final bool isAuthenticated;
  final Session? session;

  const AppAuthState._(this.isAuthenticated, this.session);

  factory AppAuthState.authenticated(Session session) =>
      AppAuthState._(true, session);

  factory AppAuthState.unauthenticated() => AppAuthState._(false, null);

  factory AppAuthState.unknown() => AppAuthState._(false, null);
}

class AuthProvider extends StateNotifier<AppAuthState> {
  late final StreamSubscription _subscription;
  final ObserveAuthStateUseCase _observeAuthStateUsecase;
  final AuthUseCase _authUseCase;
  final ApiAuthUseCase _apiAuthUseCase;
  final Ref _ref;
  AuthProvider({
    required ObserveAuthStateUseCase observeAuthStateUsecase,
    required AuthUseCase authUseCase,
    required ApiAuthUseCase apiAuthUseCase,
    required Ref ref,
  }) : _observeAuthStateUsecase = observeAuthStateUsecase,
       _authUseCase = authUseCase,
       _apiAuthUseCase = apiAuthUseCase,
       _ref = ref,
       super(AppAuthState.unknown()) {
    listenToAuthState();
  }

  Future<void> signInWithGoogle() async {
    state = AppAuthState.unknown();
    try {
      await _authUseCase.signInWithGoogle();
    } catch (e) {
      state = AppAuthState.unauthenticated();
    }
  }

  void listenToAuthState() {
    _observeAuthStateUsecase.check().listen((authState) async {
      if (authState.event == AuthChangeEvent.signedIn &&
          authState.session != null) {
        final roleFromState = _ref.read(roleProvider);
        print(authState.session?.user.userMetadata);
        final userMetadata = authState.session?.user.userMetadata;
        final GoogleAuthModel data = GoogleAuthModel(
          name:
              userMetadata?["full_name"] ??
              userMetadata?["name"] ??
              authState.session!.user.userMetadata?["display_name"] ??
              authState.session!.user.email?.split('@').first ??
              "User",
          email: authState.session!.user.email!,
          avatar: userMetadata?["avatar_url"] ?? userMetadata?["avatar"] ?? "",
          role: roleFromState,
        );
        final response = await _apiAuthUseCase.signInWithGoogle(data);
        print("response in listener is ${response.data}");
        print("from server: ${response.data}");

        state = AppAuthState.authenticated(authState.session!);

        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => CallbackScreen(user: UserModel.fromJSON(response)),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final authNotifierProvider = StateNotifierProvider<AuthProvider, AppAuthState>((
  ref,
) {
  final observeAuthStateUseCase = ref.read(observeAuthStateUsecaseProvider);
  final authUseCase = ref.read(authUseCaseProvider);
  final apiAuthUseCase = ref.read(apiAuthUseCaseProvider);
  return AuthProvider(
    observeAuthStateUsecase: observeAuthStateUseCase,
    authUseCase: authUseCase,
    apiAuthUseCase: apiAuthUseCase,
    ref: ref,
  );
});

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});
