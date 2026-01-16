import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find<StorageService>();

  static const _tokenKey = 'token';
  static const _localeKey = 'locale';
  static const _themeKey = 'theme';

  late final GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }

  String? get token => _box.read<String>(_tokenKey);
  Future<void> setToken(String? value) async {
    if (value == null || value.isEmpty) {
      await _box.remove(_tokenKey);
      return;
    }
    await _box.write(_tokenKey, value);
  }

  Locale? get locale {
    final value = _box.read<String>(_localeKey);
    if (value == null || value.isEmpty) return null;
    final parts = value.split('_');
    if (parts.isEmpty) return null;
    if (parts.length == 1) return Locale(parts[0]);
    return Locale(parts[0], parts[1]);
  }

  Future<void> setLocale(Locale? value) async {
    if (value == null) {
      await _box.remove(_localeKey);
      return;
    }
    final code = value.countryCode == null
        ? value.languageCode
        : '${value.languageCode}_${value.countryCode}';
    await _box.write(_localeKey, code);
  }

  String? get themeMode => _box.read<String>(_themeKey);
  Future<void> setThemeMode(String? value) async {
    if (value == null || value.isEmpty) {
      await _box.remove(_themeKey);
      return;
    }
    await _box.write(_themeKey, value);
  }
}
