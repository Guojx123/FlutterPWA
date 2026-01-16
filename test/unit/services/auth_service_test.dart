import 'package:flutter_test/flutter_test.dart';
import 'package:template/app/data/services/auth_service.dart';
import 'package:template/app/data/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  setUp(() async {
    // 初始化测试环境
    await GetStorage.init();
    Get.put(StorageService());
    Get.put(AuthService());
  });

  tearDown(() {
    // 清理测试环境
    Get.reset();
  });

  group('AuthService Tests', () {
    test('isLoggedIn should return false when no token', () {
      final authService = Get.find<AuthService>();
      final storageService = Get.find<StorageService>();

      // 清除 token
      storageService.setToken(null);

      expect(authService.isLoggedIn, false);
    });

    test('isLoggedIn should return true when token exists', () async {
      final authService = Get.find<AuthService>();
      final storageService = Get.find<StorageService>();

      // 设置 token
      await storageService.setToken('test_token');

      expect(authService.isLoggedIn, true);
    });

    test('logout should clear token', () async {
      final authService = Get.find<AuthService>();
      final storageService = Get.find<StorageService>();

      // 设置 token
      await storageService.setToken('test_token');
      expect(storageService.token, 'test_token');

      // 登出
      await authService.logout();

      expect(storageService.token, isNull);
    });
  });
}
