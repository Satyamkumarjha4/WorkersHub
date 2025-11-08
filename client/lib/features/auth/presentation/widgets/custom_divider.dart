import 'package:client/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.0,
      children: [
        Expanded(
          child: Divider(color: AppColors.tertiaryTextColor, thickness: 0.6),
        ),
        Text(
          "or continue with",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: 12.0),
        ),
        Expanded(
          child: Divider(color: AppColors.tertiaryTextColor, thickness: 0.6),
        ),
      ],
    );
  }
}
