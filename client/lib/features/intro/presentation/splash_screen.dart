import 'dart:async';
import 'package:client/core/constants/colors.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/client/presentation/screens/client_dashboard_screen.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final supabaseClient = ref.read(supabaseClientProvider);
      print(supabaseClient.auth.currentSession);
      if (supabaseClient.auth.currentSession == null) {
        // ✅ Navigate immediately if user already logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ClientDashboardScreen(),
          ),
        );
      } else {
        // ✅ Otherwise, show splash for 3s then go to login
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: [
            const Icon(Icons.handyman, color: Colors.white),
            Text(
              "WorkersHub",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
