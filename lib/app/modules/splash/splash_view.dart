import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/page_container.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(child: Center(child: Text(TrKeys.splashLoading.tr)));
  }
}
