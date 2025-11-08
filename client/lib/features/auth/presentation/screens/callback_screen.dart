import 'package:client/core/constants/colors.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/features/client/presentation/screens/client_dashboard_screen.dart';
import 'package:client/features/worker/presentation/screens/worker_dashboard_screen.dart';
import 'package:client/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallbackScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const CallbackScreen({super.key, required this.user});

  @override
  ConsumerState<CallbackScreen> createState() => _CallbackScreenState();
}

class _CallbackScreenState extends ConsumerState<CallbackScreen> {
  @override
  void initState() {
    super.initState();

    print("on callback screen");
    print("User name: ${widget.user.name}");
    print("User role: ${widget.user.role}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetScreen = widget.user.role == Role.client
          ? const ClientDashboardScreen()
          : const WorkerDashboardScreen();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => targetScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(),
            SizedBox(width: 10),
            Text("Please wait..."),
          ],
        ),
      ),
    );
  }
}
