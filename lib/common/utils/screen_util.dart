import 'package:get/get.dart';

/// 屏幕适配工具类（基于 GetX）
class ScreenUtil {
  /// 设计稿宽度（默认 375）
  static const double _designWidth = 375;

  /// 设计稿高度（默认 812）
  static const double _designHeight = 812;

  /// 屏幕宽度
  static double get screenWidth => Get.width;

  /// 屏幕高度
  static double get screenHeight => Get.height;

  /// 状态栏高度
  static double get statusBarHeight => Get.mediaQuery.padding.top;

  /// 底部安全区高度
  static double get bottomBarHeight => Get.mediaQuery.padding.bottom;

  /// 宽度比例
  static double get scaleWidth => Get.width / _designWidth;

  /// 高度比例
  static double get scaleHeight => Get.height / _designHeight;

  /// 根据设计稿宽度适配
  static double w(num width) => width * scaleWidth;

  /// 根据设计稿高度适配
  static double h(num height) => height * scaleHeight;

  /// 根据宽高最小比例适配（用于字体）
  static double sp(num fontSize) => fontSize * scaleWidth.clamp(0.8, 1.2);

  /// 设备类型判断
  static bool get isTablet => Get.width > 600;
  static bool get isPhone => !isTablet;
  static bool get isLandscape => Get.width > Get.height;
  static bool get isPortrait => !isLandscape;
}

/// 屏幕适配扩展
extension SizeExtension on num {
  /// 根据设计稿宽度适配
  double get w => ScreenUtil.w(this);

  /// 根据设计稿高度适配
  double get h => ScreenUtil.h(this);

  /// 字体适配
  double get sp => ScreenUtil.sp(this);
}
