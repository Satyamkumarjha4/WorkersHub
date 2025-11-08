import 'package:client/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final String placeholder;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.label,
    required this.placeholder,
  });
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      cursorColor: AppColors.secondaryTextColor,
      obscureText: widget.type == TextInputType.visiblePassword,
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeholder,
        labelStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppColors.secondaryTextColor),
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.tertiaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.secondaryTextColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.secondaryTextColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
