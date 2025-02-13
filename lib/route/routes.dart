// 路由管理
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/auth/login_page.dart';
import 'package:wanandroid_flutter/pages/auth/register_page.dart';
import 'package:wanandroid_flutter/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:wanandroid_flutter/pages/search/search_page.dart';
import 'package:wanandroid_flutter/pages/tab_page.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/18 15:05.
/// @Description     : 路由管理类


class Routes {
  // 路由
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(),settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "首页跳转来的"),settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(),settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(),settings: settings);
      case RoutePath.detailKnowledgePage:
        return pageRoute(KnowledgeDetailTabPage(),settings: settings);
      case RoutePath.searchPage:
        return pageRoute(SearchPage(),settings: settings);
    }
    return pageRoute(Scaffold(
      body: SafeArea(child: Center(child: Text("route path ${settings.name} can not find!"))),
    ));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

// 路由地址
class RoutePath {
  // 首页
  static const String tab = "/";
  // WebView
  static const String webViewPage = "/web_view_page";
  // Login
  static const String loginPage = "/login_page";
  // register
  static const String registerPage = "/register_page";
  // 体系详情页
  static const String detailKnowledgePage = "/detail_knowledge_page";
  // 搜索页
  static const String searchPage = "/search_page";
}
