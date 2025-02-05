import 'package:flutter/material.dart';
import 'package:flutter_application_11/common_ui/web/webview_page.dart';
import 'package:flutter_application_11/common_ui/web/webview_widget.dart';
import 'package:flutter_application_11/pages/about/about_us_page.dart';
import 'package:flutter_application_11/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:flutter_application_11/pages/my_collects/my_collects_page.dart';
import 'package:flutter_application_11/pages/search/search_page.dart';
import 'package:flutter_application_11/pages/tab_page.dart';
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
        return pageRoute(
            WebViewPage(
              loadResource: "",
              webViewType: WebViewType.URL,
            ),
            settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(), settings: settings);
      case RoutePath.knowledgeDetailPage:
        return pageRoute(KnowledgeDetailTabPage(), settings: settings);
      case RoutePath.searchPage:
        return pageRoute(SearchPage(), settings: settings);
      case RoutePath.myCollectsPage:
        return pageRoute(MyCollectsPage(), settings: settings);
      case RoutePath.aboutPage:
        return pageRoute(AboutUsPage(), settings: settings);
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
  // 知识详情
  static const String knowledgeDetailPage = '/knowledge_detail_page';
  // 搜索
  static const String searchPage = '/search_page';
  // 我的收藏
  static const String myCollectsPage = '/my_collects_page';
  // 关于
  static const String aboutPage = '/about_page';
}
