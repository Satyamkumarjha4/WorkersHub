import 'package:client/features/auth/data/models/google_auth_model.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? avatar;
  final Role? role;

  const UserModel({this.name, this.email, this.avatar, this.role});
}
