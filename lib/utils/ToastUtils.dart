import 'package:flutter/material.dart';

class ToastUtils {
  static void showTost(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message ?? "暂无内容",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 10),
      ),
    );
  }
}
