import 'dart:ui';
import 'package:flutter/material.dart';

/// 全局变量：控制是否启用高斯模糊
bool enablePrivacyBlur = true;

/// 高斯模糊文本组件
/// 不改变原数据，仅在展示层做模糊处理
class BlurredText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double sigmaX;
  final double sigmaY;

  const BlurredText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.sigmaX = 5.0,
    this.sigmaY = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (!enablePrivacyBlur) {
      return child;
    }

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    );
  }
}
