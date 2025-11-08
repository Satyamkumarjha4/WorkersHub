import 'package:client/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<UserModel> {
  @override
  UserModel build() => UserModel();

  void updateUser(UserModel data) {
    state = data;
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, UserModel>(
  UserNotifier.new,
);
