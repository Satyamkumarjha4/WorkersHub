import 'package:client/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryButton extends StatefulWidget {
  final Icon? icon;
  final String text;
  final Function onTap;
  final SvgPicture? svgIcon;
  const PrimaryButton({
    super.key,
    this.icon,
    required this.text,
    required this.onTap,
    this.svgIcon,
  });
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onTap();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.0),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryTextColor, AppColors.secondaryTextColor],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.icon ?? const SizedBox(),
              widget.svgIcon ?? const SizedBox(),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.secondaryBackgroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
