import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:client/core/widgets/primary_button.dart';
import 'package:client/core/widgets/secondary_button.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/auth/presentation/widgets/custom_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkerRegisterScreen extends StatefulWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  WorkerRegisterScreen({super.key});
  @override
  State<WorkerRegisterScreen> createState() => _WorkerRegisterScreenState();
}

class _WorkerRegisterScreenState extends State<WorkerRegisterScreen> {
  late TapGestureRecognizer _tapGestureRecognizer;
  bool _agreeToTNC = false;
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.primaryTextColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                "Show your skills. Get noticed. Grow your business.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 50),
              CustomTextField(
                controller: widget._nameController,
                label: "Name",
                placeholder: "Enter your name",
                type: TextInputType.text,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Row(
                spacing: 10.0,
                children: [
                  Checkbox(
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTNC = !_agreeToTNC;
                      });
                    },
                    checkColor: AppColors.secondaryBackgroundColor,
                    fillColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.secondaryTextColor;
                      }
                      return AppColors.secondaryBackgroundColor;
                    }),
                    value: _agreeToTNC,
                  ),
                  Flexible(
                    child: Text(
                      "I agree to the terms and conditions & Privacy Policy.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              PrimaryButton(onTap: () {}, text: "Sign up"),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Login Now.",
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
                onTap: () {},
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
