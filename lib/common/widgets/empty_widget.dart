import 'package:flutter/material.dart';

/// 空状态占位组件
class EmptyWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;

  const EmptyWidget({
    super.key,
    this.message,
    this.icon,
    this.onRetry,
    this.retryText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message ?? '暂无数据',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(retryText ?? '重新加载'),
            ),
          ],
        ],
      ),
    );
  }
}
