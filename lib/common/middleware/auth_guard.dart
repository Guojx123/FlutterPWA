import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/services/auth_service.dart';
import '../../app/routes/app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthService.to.isLoggedIn) return null;
    return const RouteSettings(name: Routes.login);
  }
}
