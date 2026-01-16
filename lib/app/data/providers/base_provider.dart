import 'package:get/get.dart';

import '../../../common/config/config.dart';
import '../../../common/utils/app_toast.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.baseUrl;
    httpClient.timeout = const Duration(seconds: 15);
    httpClient.addRequestModifier<dynamic>((request) {
      final token = StorageService.to.token;
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.statusCode == 401) {
        AuthService.to.logout();
      }
      final body = response.body;
      if (body is Map && body['code'] != null && body['code'] != 0) {
        final message = body['message']?.toString() ?? '请求失败';
        AppToast.show(message);
      }
      return response;
    });
    super.onInit();
  }
}
