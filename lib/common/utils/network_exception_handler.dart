import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

/// 网络异常统一处理工具类
class NetworkExceptionHandler {
  static String handleException(dynamic error) {
    if (error is SocketException) {
      return '网络连接失败，请检查网络设置';
    } else if (error is TimeoutException) {
      return '连接超时，请稍后重试';
    } else if (error is HttpException) {
      return '服务器异常，请稍后重试';
    } else if (error is FormatException) {
      return '数据格式错误';
    } else {
      if (kDebugMode) {
        debugPrint('Unknown error: $error');
      }
      return '未知错误，请稍后重试';
    }
  }

  static String handleStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '未授权，请重新登录';
      case 403:
        return '拒绝访问';
      case 404:
        return '请求的资源不存在';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务不可用';
      case 504:
        return '网关超时';
      default:
        return '请求失败（$statusCode）';
    }
  }
}
