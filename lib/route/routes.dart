import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/tab_page.dart';
import 'package:flutter_application_11/pages/web_view_page.dart';
import 'package:flutter_application_11/pages/not_found_page.dart';
import 'package:flutter_application_11/pages/auth/login_page.dart';
import 'package:flutter_application_11/pages/auth/register_page.dart';

class Routes {
  // 定义路由地址
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(), settings: settings);
      default:
        return pageRoute(NotFoundPage(settings: settings));
    }
  }

  static MaterialPageRoute pageRoute(Widget page,
      {RouteSettings? settings,
      bool? fullscreenDialog,
      bool? maintainState,
      bool? allowSnapshotting}) {
    return MaterialPageRoute(
        builder: (_) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

// 定义路由地址
class RoutePath {
  // 主页
  static const String tab = '/';
  // web视图
  static const String webViewPage = '/web_view_page';
  // 登录
  static const String loginPage = '/login_page';
  // 注册
  static const String registerPage = '/register_page';
}
