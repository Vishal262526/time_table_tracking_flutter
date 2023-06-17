import 'package:flutter/material.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';

class PrimaryInput extends StatelessWidget {
  const PrimaryInput({
    super.key,
    this.controller,
    required this.placeholder,
    this.readOnly = false,
    this.postfixIcon,
    this.onTap,
    this.securetTextEntry = false,
  });

  final String placeholder;
  final TextEditingController? controller;
  final bool readOnly;
  final IconData? postfixIcon;
  final VoidCallback? onTap;
  final bool securetTextEntry;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: securetTextEntry,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: Icon(postfixIcon),
        hintText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
