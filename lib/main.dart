import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/common/widgets/resume_theme.dart' show ResumeTheme;
import 'app/data/services/storage_service.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/theme_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'common/i18n/app_translations.dart';
import 'common/utils/logger.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GetStorage.init();
      await Get.putAsync(() => StorageService().init());
      Get.put(AuthService());
      Get.put(ThemeService());
      runApp(const MyApp());
    },
    (error, stack) {
      AppLogger.e('Global Error', error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Template',
      translations: AppTranslations(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      initialRoute: Routes.splash,
      getPages: AppPages.pages,

      theme: ResumeTheme.current(),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,

      navigatorObservers: [FlutterSmartDialog.observer],

      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: FlutterSmartDialog.init()(context, child),
        );
      },
    );
  }
}
