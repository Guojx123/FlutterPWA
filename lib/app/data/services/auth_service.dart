import 'package:get/get.dart';

import 'storage_service.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  bool get isLoggedIn {
    final token = StorageService.to.token;
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await StorageService.to.setToken(null);
  }
}
