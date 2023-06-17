import 'package:flutter/material.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';
import 'package:time_table_tracker_flutter/utils/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.onTap,
    this.backgroundColor,
  });

  final IconData prefixIcon;
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: backgroundColor ?? kPrimaryColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              prefixIcon,
              color: kWhiteColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: kButtonTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
