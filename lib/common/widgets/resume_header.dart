import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';

class ResumeHeader extends StatelessWidget {
  final ResumeContent resumeContent;

  const ResumeHeader({
    super.key,
    required this.resumeContent,
  });

  static const double _headerHeight = 220;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final profile = resumeContent.profileInformation;

    return SizedBox(
      width: double.infinity,
      height: _headerHeight,
      child: Stack(
        children: [
          // 浅色背景
          ClipPath(
            clipper: HeaderBackgroundLight(),
            child: Container(
              height: 150,
              color: theme.primaryColorLight,
            ),
          ),

          // 深色背景
          ClipPath(
            clipper: HeaderBgDark(),
            child: Container(
              height: 200,
              color: theme.primaryColor,
            ),
          ),

          // 内容区
          Positioned(
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AnimatedAvatarRing(theme: theme),
                const SizedBox(width: 16),
                Expanded(
                  child: _ProfileInfo(
                    profile: profile,
                    theme: theme,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// 带旋转环动画的头像

class _AnimatedAvatarRing extends StatefulWidget {
  final ThemeData theme;

  const _AnimatedAvatarRing({required this.theme});

  @override
  State<_AnimatedAvatarRing> createState() => _AnimatedAvatarRingState();
}

class _AnimatedAvatarRingState extends State<_AnimatedAvatarRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const double _avatarSize = 120;
  static const double _ringSize = 140; // 外圈尺寸

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(); // 循环旋转
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _ringSize,
      height: _ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 旋转环
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 6.28, // 360度旋转
                child: child,
              );
            },
            child: Container(
              width: _ringSize,
              height: _ringSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    widget.theme.primaryColor.withOpacity(0.0),
                    widget.theme.primaryColor.withOpacity(0.4),
                    widget.theme.primaryColorLight.withOpacity(0.2),
                  ],
                  startAngle: 0.0,
                  endAngle: 3.14 * 2,
                ),
              ),
            ),
          ),

          // 内部头像
          Container(
            width: _avatarSize,
            height: _avatarSize,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.theme.primaryColorLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/resume.png'),
            ),
          ),
        ],
      ),
    );
  }
}


/// 右侧信息

class _ProfileInfo extends StatelessWidget {
  final ProfileInformation profile;
  final ThemeData theme;

  const _ProfileInfo({
    required this.profile,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(profile.name, style: ResumeTheme.titleText(context)),
        const SizedBox(height: 2),
        Text(profile.designation, style: ResumeTheme.subTitleText(context)),
        const SizedBox(height: 10),
        _InfoRow(icon: Icons.call, text: profile.contactNumber, theme: theme),
        _InfoRow(icon: Icons.wechat, text: profile.wechat, theme: theme),
        _InfoRow(icon: Icons.email, text: profile.email, theme: theme),
        const SizedBox(height: 6),
        //_SocialRow(profile: profile, theme: theme),
      ],
    );
  }
}


/// 单行信息

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final ThemeData theme;

  const _InfoRow({required this.icon, required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.primaryColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: ResumeTheme.subTitleText(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


/// 社交按钮

class _SocialRow extends StatelessWidget {
  final ProfileInformation profile;
  final ThemeData theme;

  const _SocialRow({required this.profile, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon(FontAwesomeIcons.linkedin, profile.linkedIn),
        _icon(FontAwesomeIcons.github, profile.github),
        _icon(FontAwesomeIcons.stackOverflow, profile.stackOverFlow),
      ],
    );
  }

  Widget _icon(IconData icon, String url) {
    if (url.isEmpty) return const SizedBox.shrink();
    return IconButton(
      icon: Icon(icon, size: 18),
      color: theme.primaryColor,
      onPressed: () => _open(url),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32),
    );
  }

  Future<void> _open(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
