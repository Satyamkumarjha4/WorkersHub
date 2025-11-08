import 'package:client/features/auth/data/datasources/api_auth_data_source.dart';
import 'package:client/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:client/features/auth/data/repositories/api_auth_repository_implementation.dart';
import 'package:client/features/auth/data/repositories/supabase_auth_repository_implementation.dart';
import 'package:client/features/auth/domain/repositories/api_auth_repository.dart';
import 'package:client/features/auth/domain/repositories/supabase_auth_repository.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/dio_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabaseAuthDataSourceProvider = Provider<SupabaseAuthDataSource>((ref) {
  final supabaseClient = ref.read(supabaseClientProvider);
  return SupabaseAuthDataSource(supabaseClient);
});

final apiAuthDataSourceProvider = Provider<ApiAuthDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ApiAuthDataSource(dioClient);
});

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final supabaseAuthDataSource = ref.read(supabaseAuthDataSourceProvider);
  return SupabaseAuthRepositoryImplementation(supabaseAuthDataSource);
});

final apiAuthRepositoryProvider = Provider<ApiAuthRepository>((ref) {
  final apiAuthDataSource = ref.read(apiAuthDataSourceProvider);
  return ApiAuthRepositoryImplementation(apiAuthDataSource);
});
