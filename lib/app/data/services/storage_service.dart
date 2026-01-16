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

  // Token 相关
  String? get token => _box.read<String>(_tokenKey);
  Future<void> setToken(String? value) async {
    if (value == null || value.isEmpty) {
      await _box.remove(_tokenKey);
      return;
    }
    await _box.write(_tokenKey, value);
  }

  // Locale 相关
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

  // ThemeMode 相关
  String? get themeMode => _box.read<String>(_themeKey);
  Future<void> setThemeMode(String? value) async {
    if (value == null || value.isEmpty) {
      await _box.remove(_themeKey);
      return;
    }
    await _box.write(_themeKey, value);
  }

  // 通用方法
  T? get<T>(String key) => _box.read<T>(key);

  Future<void> set(String key, dynamic value) async {
    await _box.write(key, value);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }

  bool hasKey(String key) => _box.hasData(key);
}
