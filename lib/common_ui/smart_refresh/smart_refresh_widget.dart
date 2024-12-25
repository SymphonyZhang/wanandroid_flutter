import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/20 18:50.
/// @Description     : 下拉刷新上拉加载组件
class SmartRefreshWidget extends StatelessWidget {
  const SmartRefreshWidget(
      {super.key,
      this.enablePullDown,
      this.enablePullUp,
      this.header,
      this.footer,
      this.onRefresh,
      this.onLoading,
      required this.controller,
      required this.child});

  //启用下拉
  final bool? enablePullDown;

  //启用上拉
  final bool? enablePullUp;

  //加载头布局
  final Widget? header;

  //加载尾布局
  final Widget? footer;

  //刷新事件
  final VoidCallback? onRefresh;

  //加载事件
  final VoidCallback? onLoading;

  //刷新组件控制器
  final RefreshController controller;

  //被刷新的子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _refreshView();
  }

  Widget _refreshView() {
    return SmartRefresher(
      controller: controller,
      enablePullDown: enablePullDown ?? true,
      enablePullUp: enablePullUp ?? true,
      header: header ?? const ClassicHeader(),
      footer: footer ?? const ClassicFooter(),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }

  /*Widget _loadFoot() {
    return CustomFooter(builder: (context, mode) {
      Widget body;
      switch (mode) {
        case LoadStatus.idle:
          body = Text("上拉加载更多");
          break;
        case LoadStatus.loading:
          body = CupertinoActivityIndicator();
          break;
        case LoadStatus.failed:
          body = Text("加载失败!点击重试!");
          break;
        case LoadStatus.canLoading:
          body = Text("松手,加载更多!");
          break;
        default:
          body = Text("没有更多数据了!");
          break;
      }
      return Container(
        height: 55.0.h,
        child: Center(child: body),
      );
    });
  }*/
}
