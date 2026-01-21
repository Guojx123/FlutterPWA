import 'package:flutter/material.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';
import 'resume_theme.dart';

/// 简历模块头部标题（双层裁剪 + 渐变 + 阴影效果）
class HeaderTitle extends StatelessWidget {
  final TitleModel mTitle;

  const HeaderTitle({
    super.key,
    required this.mTitle,
  });

  static const double _height = 40;
  static const EdgeInsets _padding =
  EdgeInsets.symmetric(horizontal: 16, vertical: 6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          /// 底层（深色 + 阴影）
          _ClippedHeaderBar(
            width: screenWidth * 0.75,
            color: theme.primaryColor,
            radius: 12,
            shadow: true,
          ),

          /// 顶层（浅色 + 标题 + 内边距）
          _ClippedHeaderBar(
            width: screenWidth * 0.68,
            color: theme.primaryColorLight,
            radius: 8,
            child: Padding(
              padding: _padding,
              child: Text(
                mTitle.title,
                style: ResumeTheme.titleText(context)?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClippedHeaderBar extends StatelessWidget {
  final double width;
  final Color color;
  final double radius;
  final Widget? child;
  final bool shadow;

  const _ClippedHeaderBar({
    required this.width,
    required this.color,
    required this.radius,
    this.child,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(radius),
      child: Container(
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(
          color: color,
          boxShadow: shadow
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ]
              : [],
        ),
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  final double radius;

  const HeaderClipper(this.radius);

  @override
  Path getClip(Size size) {
    // 使用更圆润的贝塞尔曲线，增加流畅感
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(
      size.width * 0.85,
      radius * 0.8,
      size.width - radius,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant HeaderClipper oldClipper) {
    return oldClipper.radius != radius;
  }
}
