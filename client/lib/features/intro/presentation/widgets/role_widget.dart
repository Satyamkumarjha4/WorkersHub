import 'package:client/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoleWidget extends StatefulWidget {
  final bool active;
  final String imagePath;
  final String role;
  final String description;
  const RoleWidget({
    super.key,
    required this.active,
    required this.description,
    required this.role,
    required this.imagePath,
  });
  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: widget.active
            ? Border.all(color: AppColors.secondaryTextColor)
            : null,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.imagePath,
              width: 50.0,
              height: 50.0,
              colorFilter: !widget.active
                  ? const ColorFilter.matrix([
                      0.5, 0, 0, 0, 0, // Red
                      0, 0.5, 0, 0, 0, // Green
                      0, 0, 0.5, 0, 0, // Blue
                      0, 0, 0, 1, 0, // Alpha
                    ])
                  : const ColorFilter.matrix([
                      1, 0, 0, 0, 0, // Red
                      0, 1, 0, 0, 0, // Green
                      0, 0, 1, 0, 0, // Blue
                      0, 0, 0, 1, 0, // Alpha
                    ]),
            ),
            const SizedBox(height: 10),
            Text(
              widget.role,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: widget.active
                    ? AppColors.primaryTextColor
                    : AppColors.tertiaryTextColor,
              ),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.active
                    ? AppColors.tertiaryTextColor
                    : AppColors.disabledTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
