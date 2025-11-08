import 'package:app_links/app_links.dart';
import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:client/core/widgets/primary_button.dart';
import 'package:client/core/widgets/secondary_button.dart';
import 'package:client/features/auth/presentation/screens/callback_screen.dart';
import 'package:client/features/auth/presentation/widgets/custom_divider.dart';
import 'package:client/features/intro/presentation/role_screen.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TapGestureRecognizer _tapGestureRecognizer;
  final appLinks = AppLinks();
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoleScreen()),
        );
      };

    // appLinks.uriLinkStream.listen((uri) async {
    //   print("inside auth callback: ${uri.host} ${uri.toString()}");
    //   if (uri.toString().isNotEmpty && uri.host == 'auth-callback') {
    //     print("inside auth callback");
    //     final supabaseClient = ref.read(supabaseClientProvider);
    //     final authenticated = ref.read(authNotifierProvider).isAuthenticated;
    //     await supabaseClient.auth.getSessionFromUrl(uri);
    //     print("got session url");
    //     final screen = uri.queryParameters['screen'];

    //     if (screen == 'callback') {
    //       if (mounted && authenticated) {
    //         print("before navigating to callback");
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => CallbackScreen()),
    //         );
    //       }
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Good to see you again!",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 50),
              CustomTextField(
                controller: widget._emailController,
                label: "Email",
                placeholder: "Enter your email address",
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: widget._passwordController,
                label: "Password",
                placeholder: "Enter your password",
                type: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 30),
              PrimaryButton(onTap: () {}, text: "Sign in"),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Register Now.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                        recognizer: _tapGestureRecognizer,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              CustomDivider(),
              const SizedBox(height: 30),
              SecondaryButton(
                onTap: () {
                  ref.read(authNotifierProvider.notifier).signInWithGoogle();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Initiating signing in...")),
                  );
                },
                svgIcon: SvgPicture.asset(
                  "lib/assets/icons/google.svg",
                  width: 30.0,
                  height: 30.0,
                ),
                text: "Continue with Google",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
