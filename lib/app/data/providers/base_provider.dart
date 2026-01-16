import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../common/config/config.dart';
import '../../../common/utils/app_toast.dart';
import '../../../common/utils/network_exception_handler.dart';
import '../../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);

    // 请求拦截器：自动注入 Token 和通用 Headers
    httpClient.addRequestModifier<dynamic>((request) {
      final token = StorageService.to.token;
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      if (kDebugMode) {
        debugPrint('[HTTP Request] ${request.method} ${request.url}');
        if (request.headers.isNotEmpty) {
          debugPrint('[Headers] ${request.headers}');
        }
      }
      return request;
    });

    // 响应拦截器：统一处理业务错误码和 HTTP 状态码
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (kDebugMode) {
        debugPrint('[HTTP Response] ${response.statusCode} ${request.url}');
      }

      // 处理 401 未授权
      if (response.statusCode == 401) {
        AuthService.to.logout();
        Get.offAllNamed(Routes.login);
        AppToast.show('登录已过期，请重新登录');
        return response;
      }

      // 处理其他 HTTP 错误状态码
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        final message = NetworkExceptionHandler.handleStatusCode(
          response.statusCode!,
        );
        AppToast.show(message);
      }

      // 处理业务错误码（假设后端返回格式：{code: xxx, message: xxx, data: xxx}）
      final body = response.body;
      if (body is Map && body['code'] != null) {
        final code = body['code'] as int;
        if (code != 200 && code != 0) {
          // 非成功业务码
          final message = body['message']?.toString() ?? '请求失败';
          AppToast.show(message);
        }
      }

      return response;
    });

    super.onInit();
  }

  /// 统一错误处理
  Future<T?> handleRequest<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      if (response.hasError) {
        final message = NetworkExceptionHandler.handleException(
          response.statusText ?? response.statusCode,
        );
        AppToast.show(message);
        return null;
      }
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[HTTP Error] $e');
      }
      final message = NetworkExceptionHandler.handleException(e);
      AppToast.show(message);
      return null;
    }
  }
}
