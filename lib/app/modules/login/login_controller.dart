import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/storage_service.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    if (accountController.text.trim().isEmpty ||
        passwordController.text.isEmpty)
      return;
    isLoading.value = true;
    await StorageService.to.setToken('demo_token');
    isLoading.value = false;
    Get.offAllNamed(Routes.home);
  }

  @override
  void onClose() {
    accountController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
