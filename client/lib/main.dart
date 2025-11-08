import 'package:client/core/constants/colors.dart';
import 'package:client/core/constants/secrets.dart';
import 'package:client/core/constants/sizes.dart';
import 'package:client/features/intro/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey: Secrets.supabaseAnonKey,
    url: Secrets.supabaseProjectUrl,
  );
  runApp(ProviderScope(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.secondaryTextColor,
          selectionHandleColor: AppColors.secondaryTextColor,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.nunito(
            color: AppColors.primaryTextColor,
            fontSize: AppSizes.titleLargeSize,
            fontWeight: FontWeight.w800,
          ),
          titleMedium: GoogleFonts.nunito(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.titleMediumSize,
            fontWeight: FontWeight.w800,
          ),
          bodyMedium: GoogleFonts.nunito(
            color: AppColors.tertiaryTextColor,
            fontSize: AppSizes.bodyMediumSize,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: GoogleFonts.nunito(
            color: AppColors.secondaryTextColor,
            fontSize: AppSizes.labelMediumSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
