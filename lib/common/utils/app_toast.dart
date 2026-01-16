import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppToast {
  static bool _loadingShown = false;

  static void show(String message) {
    if (message.isEmpty) return;
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const SizedBox.shrink(),
      margin: const EdgeInsets.all(16),
    );
  }

  static void showLoading([String? message]) {
    if (_loadingShown || Get.isDialogOpen == true) return;
    _loadingShown = true;
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(width: 12),
                  Text(message, style: const TextStyle(color: Colors.white)),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    ).whenComplete(() => _loadingShown = false);
  }

  static void dismissLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static Future<void> confirm({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) async {
    await Get.defaultDialog(
      title: title,
      middleText: content,
      onConfirm: onConfirm,
      onCancel: () {},
      textConfirm: '确定',
      textCancel: '取消',
    );
  }
}
