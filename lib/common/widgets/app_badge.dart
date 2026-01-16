import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.child, required this.count});

  final Widget child;
  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    final text = count > 99 ? '99+' : '$count';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -6,
          top: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
