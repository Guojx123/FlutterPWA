import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 网络图片组件（带缓存）
class AppImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            color: Colors.grey[200],
            child: Icon(Icons.broken_image, color: Colors.grey[400], size: 40),
          ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  /// 圆形头像
  static Widget avatar(
    String url, {
    double size = 40,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return ClipOval(
      child: AppImage(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: placeholder,
        errorWidget: errorWidget,
      ),
    );
  }

  /// 圆角图片
  static Widget rounded(
    String url, {
    double? width,
    double? height,
    double radius = 8,
    BoxFit fit = BoxFit.cover,
  }) {
    return AppImage(
      url,
      width: width,
      height: height,
      fit: fit,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
