import 'package:client/core/constants/colors.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.0,
      children: [
        Expanded(
          child: CustomTextField(
            controller: _controller,
            type: TextInputType.text,
            label: "",
            placeholder: "Search for workers...",
          ),
        ),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: AppColors.secondaryBackgroundColor,
          ),
          icon: Icon(Icons.notifications, color: AppColors.secondaryTextColor),
        ),
      ],
    );
  }
}
