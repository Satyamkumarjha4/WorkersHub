import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateChangeEventModel {
  final AuthChangeEvent event;
  final Session? session;

  const AuthStateChangeEventModel({required this.event, required this.session});
}
