import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 统一 Toast/Loading/Dialog 工具类
class AppToast {
  /// 显示普通提示
  static void show(String message) {
    if (message.isEmpty) return;
    SmartDialog.showToast(message);
  }

  /// 显示成功提示
  static void success(String message) {
    if (message.isEmpty) return;
    SmartDialog.showToast(message, displayType: SmartToastType.last);
  }

  /// 显示错误提示
  static void error(String message) {
    if (message.isEmpty) return;
    SmartDialog.showToast(message, displayType: SmartToastType.last);
  }

  /// 显示 Loading
  static void showLoading([String? message]) {
    SmartDialog.showLoading(msg: message ?? '加载中...');
  }

  /// 关闭 Loading
  static void dismissLoading() {
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  /// 显示确认对话框
  static Future<bool> confirm({
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
  }) async {
    final result = await SmartDialog.show<bool>(
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => SmartDialog.dismiss(result: false),
              child: Text(cancelText ?? '取消'),
            ),
            TextButton(
              onPressed: () => SmartDialog.dismiss(result: true),
              child: Text(confirmText ?? '确认'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// 显示自定义对话框
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) async {
    return await SmartDialog.show<T>(
      builder: (_) => child,
      clickMaskDismiss: barrierDismissible,
    );
  }
}
