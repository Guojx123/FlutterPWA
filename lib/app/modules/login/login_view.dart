import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/page_container.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TrKeys.loginTitle.tr,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: controller.accountController,
              hintText: TrKeys.loginAccount.tr,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.passwordController,
              hintText: TrKeys.loginPassword.tr,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: TrKeys.loginButton.tr,
                  loading: controller.isLoading.value,
                  onPressed: controller.login,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
