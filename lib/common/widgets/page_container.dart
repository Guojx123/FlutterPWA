import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    required this.child,
    this.safeArea = true,
    this.backgroundColor,
  });

  final Widget child;
  final bool safeArea;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget body = child;
    if (safeArea) {
      body = SafeArea(child: body);
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(backgroundColor: backgroundColor, body: body),
    );
  }
}
