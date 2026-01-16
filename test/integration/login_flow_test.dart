import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:template/main.dart' as app;
import 'package:get/get.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Test', () {
    testWidgets('Complete login flow', (WidgetTester tester) async {
      // 启动应用
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 等待 Splash 页面跳转到登录页
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 查找用户名和密码输入框
      final usernameField = find.byKey(const Key('username_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final loginButton = find.text('登录');

      // 如果找到了登录页面元素
      if (tester.any(usernameField)) {
        // 输入用户名和密码
        await tester.enterText(usernameField, 'test_user');
        await tester.enterText(passwordField, 'test_password');
        await tester.pump();

        // 点击登录按钮
        await tester.tap(loginButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // 验证是否跳转到主页
        expect(find.text('首页'), findsOneWidget);
      }
    });
  });
}
