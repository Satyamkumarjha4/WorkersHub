import 'package:client/features/auth/data/models/auth_response.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? avatar;
  final Role? role;
  final List<dynamic>? messages;

  const UserModel({
    this.name,
    this.email,
    this.avatar,
    this.role,
    this.id,
    this.messages,
  });

  factory UserModel.fromJSON(AuthResponse response) {
    print("response in user model is ${response.data}");
    Role? role;
    if (response.data?["role"] == "Client") {
      role = Role.client;
    } else if (response.data?["role"] == "Worker") {
      role = Role.worker;
    }

    return UserModel(
      id: response.data?["id"],
      name: response.data?["name"],
      email: response.data?["email"],
      avatar: response.data?["avatar"],
      role: role,
      messages: [],
    );
  }
}
