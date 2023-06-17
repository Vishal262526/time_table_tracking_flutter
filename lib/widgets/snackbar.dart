import 'package:flutter/material.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      content: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, color: kWhiteColor),
      ),
    ),
  );
}
