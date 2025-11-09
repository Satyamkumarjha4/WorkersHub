import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/models/user_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final userNotifierProvider = StateProvider<UserModel>((ref) {
  final UserModel user = UserModel(
    id: "",
    name: "",
    avatar: "",
    email: "",
    role: Role.client,
  );
  return user;
});
