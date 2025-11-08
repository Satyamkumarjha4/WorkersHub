import 'package:client/features/auth/data/datasources/api_auth_data_source.dart';
import 'package:client/features/auth/data/models/auth_response.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/features/auth/domain/repositories/api_auth_repository.dart';

class ApiAuthRepositoryImplementation extends ApiAuthRepository {
  final ApiAuthDataSource _dataSource;
  ApiAuthRepositoryImplementation(this._dataSource);

  @override
  Future<AuthResponse> signInWithGoogle(GoogleAuthModel data) async {
    return _dataSource.signInWithGoogle(data);
  }
}
