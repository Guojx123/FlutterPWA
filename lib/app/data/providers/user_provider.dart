import 'package:get/get.dart';

import '../../../common/config/config.dart';

/// 用户 Provider（示例）
class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.baseUrl;
    super.onInit();
  }

  /// 获取用户资料
  Future<Response> getProfile() {
    return get('/user/profile');
  }

  /// 更新用户资料
  Future<Response> updateProfile(Map<String, dynamic> data) {
    return put('/user/profile', data);
  }
}
