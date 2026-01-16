import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/page_container.dart';

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
    return PageContainer(
      child: Obx(() {
        final signal = refreshSignals[tabIndex];
        return KeyedSubtree(
          key: ValueKey('home_$signal'),
          child: ListView.builder(
            controller: scrollController,
            itemCount: 30,
            itemBuilder: (_, i) =>
                ListTile(title: Text('${TrKeys.homeTitle.tr} $i')),
          ),
        );
      }),
    );
  }
}
