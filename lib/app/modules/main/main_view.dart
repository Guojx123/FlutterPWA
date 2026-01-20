import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/app_badge.dart';
import '../discover/discover_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeView(
              scrollController: controller.scrollControllers[0],
              refreshSignals: controller.refreshSignals,
              tabIndex: 0,
            ),
            DiscoverView(
              scrollController: controller.scrollControllers[1],
              refreshSignals: controller.refreshSignals,
              tabIndex: 1,
            ),
            ProfileView(
              scrollController: controller.scrollControllers[2],
              refreshSignals: controller.refreshSignals,
              tabIndex: 2,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.onTap,
          items: [
            BottomNavigationBarItem(
              icon: AppBadge(count: 0, child: const Icon(Icons.home)),
              label: TrKeys.tabHome.tr,
            ),
            BottomNavigationBarItem(
              icon: AppBadge(count: 0, child: const Icon(Icons.explore)),
              label: TrKeys.tabDiscover.tr,
            ),
            BottomNavigationBarItem(
              icon: AppBadge(count: 0, child: const Icon(Icons.person)),
              label: TrKeys.tabProfile.tr,
            ),
          ],
        ),
      );
    });
  }
}
