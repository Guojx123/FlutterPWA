import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;
  final refreshSignals = <int>[0, 0, 0].obs;
  final List<ScrollController> scrollControllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];
  final Map<int, DateTime> _lastTap = {};

  void onTap(int index) {
    final now = DateTime.now();
    final last = _lastTap[index];
    if (currentIndex.value == index &&
        last != null &&
        now.difference(last).inMilliseconds < 300) {
      _scrollToTop(index);
      refreshSignals[index] = refreshSignals[index] + 1;
    }
    currentIndex.value = index;
    _lastTap[index] = now;
  }

  void _scrollToTop(int index) {
    final controller = scrollControllers[index];
    if (!controller.hasClients) return;
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void onClose() {
    for (final c in scrollControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
