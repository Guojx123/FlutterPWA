import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'storage_service.dart';

class ThemeService extends GetxService {
  static ThemeService get to => Get.find<ThemeService>();

  final themeMode = ThemeMode.system.obs;

  Future<void> load() async {
    final raw = StorageService.to.themeMode;
    if (raw == 'light') themeMode.value = ThemeMode.light;
    if (raw == 'dark') themeMode.value = ThemeMode.dark;
    if (raw == 'system') themeMode.value = ThemeMode.system;
  }

  Future<void> setMode(ThemeMode mode) async {
    themeMode.value = mode;
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await StorageService.to.setThemeMode(value);
  }
}
