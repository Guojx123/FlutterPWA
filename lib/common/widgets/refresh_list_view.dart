import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 下拉刷新/上拉加载列表容器
class RefreshListView extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback? onLoading;
  final Widget child;
  final bool enablePullDown;
  final bool enablePullUp;
  final String? refreshText;
  final String? loadingText;
  final String? noDataText;

  const RefreshListView({
    super.key,
    required this.controller,
    required this.onRefresh,
    required this.child,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.refreshText,
    this.loadingText,
    this.noDataText,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp && onLoading != null,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: WaterDropHeader(
        complete: Text(
          refreshText ?? '刷新完成',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        refresh: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(
              loadingText ?? '上拉加载更多',
              style: TextStyle(color: Colors.grey[600]),
            );
          } else if (mode == LoadStatus.loading) {
            body = const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (mode == LoadStatus.failed) {
            body = Text('加载失败，点击重试', style: TextStyle(color: Colors.grey[600]));
          } else if (mode == LoadStatus.canLoading) {
            body = Text('松开加载更多', style: TextStyle(color: Colors.grey[600]));
          } else {
            body = Text(
              noDataText ?? '没有更多数据了',
              style: TextStyle(color: Colors.grey[600]),
            );
          }
          return Container(
            height: 55.0,
            alignment: Alignment.center,
            child: body,
          );
        },
      ),
      child: child,
    );
  }
}
