import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制

  static bool isShowLoading = false;

  static void showTost(BuildContext context, String? message) {
    if (ToastUtils.isShowLoading) {
      return;
    }
    ToastUtils.isShowLoading = true;

    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.isShowLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message ?? "暂无内容",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
