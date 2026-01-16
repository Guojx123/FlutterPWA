import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/page_container.dart';
import '../../../common/widgets/refresh_list_view.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.scrollController,
    required this.refreshSignals,
    required this.tabIndex,
  });

  final ScrollController scrollController;
  final RxList<int> refreshSignals;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    // 为了演示下拉刷新，临时创建 HomeController
    final homeController = Get.put(HomeController(), tag: 'home_$tabIndex');

    return PageContainer(
      child: Obx(() {
        final signal = refreshSignals[tabIndex];
        return KeyedSubtree(
          key: ValueKey('home_$signal'),
          child: RefreshListView(
            controller: homeController.refreshController,
            onRefresh: homeController.onRefresh,
            onLoading: homeController.onLoading,
            child: ListView.builder(
              controller: scrollController,
              itemCount: homeController.items.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(
                  '${TrKeys.homeTitle.tr} ${homeController.items[i]}',
                ),
                subtitle: Text('这是第 $i 项的描述'),
              ),
            ),
          ),
        );
      }),
    );
  }
}
