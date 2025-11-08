import 'package:client/features/auth/data/providers.dart';
import 'package:client/features/auth/domain/repositories/api_auth_repository.dart';
import 'package:client/features/auth/domain/repositories/supabase_auth_repository.dart';
import 'package:client/features/auth/domain/usecases/api_auth_use_case.dart';
import 'package:client/features/auth/domain/usecases/auth_usecase.dart';
import 'package:client/features/auth/domain/usecases/observe_auth_state_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final observeAuthStateUsecaseProvider = Provider<ObserveAuthStateUseCase>((
  ref,
) {
  final SupabaseAuthRepository repository = ref.read(authRepositoryProvider);
  return ObserveAuthStateUseCase(repository);
});

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final SupabaseAuthRepository repository = ref.read(authRepositoryProvider);
  return AuthUseCase(repository);
});

final apiAuthUseCaseProvider = Provider<ApiAuthUseCase>((ref) {
  final ApiAuthRepository repository = ref.read(apiAuthRepositoryProvider);
  return ApiAuthUseCase(repository);
});
