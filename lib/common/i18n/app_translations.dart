import 'package:get/get.dart';

import 'translation_keys.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      TrKeys.appName: '模版',
      TrKeys.splashLoading: '加载中',
      TrKeys.loginTitle: '登录',
      TrKeys.loginAccount: '账号',
      TrKeys.loginPassword: '密码',
      TrKeys.loginButton: '登录',
      TrKeys.homeTitle: '首页',
      TrKeys.tabHome: '首页',
      TrKeys.tabDiscover: '发现',
      TrKeys.tabProfile: '我的',
    },
    'en_US': {
      TrKeys.appName: 'Template',
      TrKeys.splashLoading: 'Loading',
      TrKeys.loginTitle: 'Login',
      TrKeys.loginAccount: 'Account',
      TrKeys.loginPassword: 'Password',
      TrKeys.loginButton: 'Login',
      TrKeys.homeTitle: 'Home',
      TrKeys.tabHome: 'Home',
      TrKeys.tabDiscover: 'Discover',
      TrKeys.tabProfile: 'Profile',
    },
  };
}
