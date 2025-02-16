import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/common_ui/common_widget.dart';
import 'package:wanandroid_flutter/common_ui/webview_page.dart';
import 'package:wanandroid_flutter/common_ui/webview_widget.dart';
import 'package:wanandroid_flutter/repository/datas/my_collects_data.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

import '../../common_ui/smart_refresh/smart_refresh_widget.dart';
import 'my_collects_vm.dart';

class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<MyCollectsPage> createState() => _MyCollectsPageState();
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  var model = MyCollectsViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    model.initCollectsData();
  }

  /// 上拉加载回调
  void _onLoading() async {
    model.loadMoreData().then((value) {
      _refreshController.loadComplete();
    });
  }

  /// 下拉刷新回调
  void _onRefresh() async {
    model.refreshData().then((value) {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return model;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("我的收藏"),),
        backgroundColor: Colors.white,
        body: SafeArea(child: Consumer<MyCollectsViewModel>(
          builder: (context, vm, child) {
            return SmartRefreshWidget(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(itemCount: vm.dataList?.length ?? 0, itemBuilder: (context, index) {
                return _collectItem(vm.dataList?[index], onTap: () {
                  //取消收藏
                  model.cancelCollect(index, "${vm.dataList?[index].id}","${vm.dataList?[index].originId ?? -1}");
                }, itemClick: () {
                  //进入网页
                  RouteUtils.push(context, WebviewPage(webViewType: WebViewType.URL, loadResource: vm.dataList?[index].link ?? "", showTitle: true, title: vm.dataList?[index].title));
                });
              },),
            );
          },
        )),
      ),
    );
    //const Placeholder();
  }

  Widget _collectItem(MyCollectItemData? item, {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
      onTap: itemClick,
      child: Container(
          margin: EdgeInsets.all(10.r),
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: Text("作者: ${item?.author}")),
                Text("时间: ${item?.niceDate}")]
              ),
              SizedBox(height: 6.h),
              Text("${item?.title}",style: titleTextStyle15),
              Row(children: [
                Expanded(child: Text("分类: ${item?.chapterName}")),
                collectImage(true,onTap:onTap)
              ],)
            ],)
      ),
    );
  }
}
