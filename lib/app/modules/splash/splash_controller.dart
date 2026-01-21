import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../data/services/storage_service.dart';
import '../../data/services/theme_service.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final _auth = AuthService.to;
  final _storage = StorageService.to;
  final _theme = ThemeService.to;

  @override
  void onReady() {
    super.onReady();
    debugPrint('[Splash] onReady called');
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // 模拟启动耗时
    await Future.delayed(const Duration(seconds: 1));
    await _theme.load();
    final locale = _storage.locale;
    if (locale != null) {
      Get.updateLocale(locale);
    }
    final isLoggedIn = _auth.isLoggedIn;
    // final target = isLoggedIn ? Routes.home : Routes.login;
    final target =Routes.home ;
    Get.offAllNamed(target);
  }
}
