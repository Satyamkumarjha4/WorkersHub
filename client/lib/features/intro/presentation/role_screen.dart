import 'package:client/core/constants/colors.dart';
import 'package:client/core/constants/sizes.dart';
import 'package:client/core/widgets/primary_button.dart';
import 'package:client/features/auth/data/models/google_auth_model.dart';
import 'package:client/features/auth/presentation/screens/customer_register_screen.dart';
import 'package:client/features/auth/presentation/screens/worker_register_screen.dart';
import 'package:client/features/intro/presentation/providers.dart';
import 'package:client/features/intro/presentation/widgets/role_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleScreen extends ConsumerStatefulWidget {
  const RoleScreen({super.key});

  @override
  ConsumerState<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends ConsumerState<RoleScreen> {
  bool _isCustomerActive = true;
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
            horizontal: 10.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsetsGeometry.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your role",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: AppSizes.titleLargeSize,
                      ),
                    ),
                    Text(
                      "Whether you need help or offer it, we’ve got you covered.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 50.0),
                    Row(
                      spacing: 10.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isCustomerActive = true;
                            });
                          },
                          child: RoleWidget(
                            active: _isCustomerActive,
                            role: "Client",
                            imagePath: "lib/assets/icons/man.svg",
                            description:
                                "Connecting you to reliable local help.",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isCustomerActive = false;
                            });
                          },
                          child: RoleWidget(
                            active: !_isCustomerActive,
                            role: "Worker",
                            description:
                                "Turn your expertise into opportunity.",
                            imagePath: "lib/assets/icons/worker.svg",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 300.0),
                    PrimaryButton(
                      text: "Continue",
                      onTap: () {
                        ref
                            .read(roleProvider.notifier)
                            .update(
                              (role) =>
                                  _isCustomerActive ? Role.client : Role.worker,
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _isCustomerActive
                                ? CustomerRegisterScreen()
                                : WorkerRegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
