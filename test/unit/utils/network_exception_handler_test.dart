import 'package:flutter_test/flutter_test.dart';
import 'package:template/common/utils/network_exception_handler.dart';
import 'dart:io';
import 'dart:async';

void main() {
  group('NetworkExceptionHandler Tests', () {
    test(
      'handleException should return correct message for SocketException',
      () {
        final exception = const SocketException('Connection failed');
        final message = NetworkExceptionHandler.handleException(exception);

        expect(message, '网络连接失败，请检查网络设置');
      },
    );

    test(
      'handleException should return correct message for TimeoutException',
      () {
        final exception = TimeoutException('Request timeout');
        final message = NetworkExceptionHandler.handleException(exception);

        expect(message, '连接超时，请稍后重试');
      },
    );

    test('handleException should return correct message for HttpException', () {
      final exception = const HttpException('Server error');
      final message = NetworkExceptionHandler.handleException(exception);

      expect(message, '服务器异常，请稍后重试');
    });

    test(
      'handleException should return correct message for FormatException',
      () {
        final exception = const FormatException('Invalid format');
        final message = NetworkExceptionHandler.handleException(exception);

        expect(message, '数据格式错误');
      },
    );

    test('handleStatusCode should return correct message for 401', () {
      final message = NetworkExceptionHandler.handleStatusCode(401);
      expect(message, '未授权，请重新登录');
    });

    test('handleStatusCode should return correct message for 404', () {
      final message = NetworkExceptionHandler.handleStatusCode(404);
      expect(message, '请求的资源不存在');
    });

    test('handleStatusCode should return correct message for 500', () {
      final message = NetworkExceptionHandler.handleStatusCode(500);
      expect(message, '服务器内部错误');
    });
  });
}
