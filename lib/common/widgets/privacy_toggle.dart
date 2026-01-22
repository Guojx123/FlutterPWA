import 'package:flutter/material.dart';
import 'blurred_text.dart';

/// 隐私开关组件
/// 用于在开发/演示模式下快速切换脱敏状态
class PrivacyToggle extends StatefulWidget {
  const PrivacyToggle({super.key});

  @override
  State<PrivacyToggle> createState() => _PrivacyToggleState();
}

class _PrivacyToggleState extends State<PrivacyToggle> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: enablePrivacyBlur,
      onChanged: (value) {
        setState(() {
          enablePrivacyBlur = value;
        });
      },
    );
  }
}
