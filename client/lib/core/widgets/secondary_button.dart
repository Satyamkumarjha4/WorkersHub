import 'package:client/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SecondaryButton extends ConsumerStatefulWidget {
  final Icon? icon;
  final SvgPicture? svgIcon;
  final String text;
  final Function onTap;
  const SecondaryButton({
    super.key,
    this.icon,
    this.svgIcon,
    required this.text,
    required this.onTap,
  });
  @override
  ConsumerState<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends ConsumerState<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onTap();
      },
      style: ElevatedButton.styleFrom(
        // maximumSize: Size.fromWidth(400.0),
        padding: EdgeInsets.zero,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.tertiaryBackgroundColor,
              AppColors.secondaryBackgroundColor,
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 50.0),
          child: Row(
            spacing: 12.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.icon ?? const SizedBox(),
              widget.svgIcon ?? const SizedBox(),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.secondaryTextColor,
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
