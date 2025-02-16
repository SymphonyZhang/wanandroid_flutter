import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/common_ui/common_widget.dart';
import 'package:wanandroid_flutter/common_ui/loading.dart';
import 'package:wanandroid_flutter/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wanandroid_flutter/common_ui/webview_page.dart';
import 'package:wanandroid_flutter/common_ui/webview_widget.dart';
import 'package:wanandroid_flutter/pages/home/home_vm.dart';
import 'package:wanandroid_flutter/repository/datas/home_list_data.dart';
import 'package:wanandroid_flutter/resource/assets.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/18 1:39.
/// @Description     : 描述
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Loading.showLoading();
    viewModel.getBanner();
    //viewModel.initListData();
    _initListData();
  }

  void _initListData() async {
    viewModel.initListData().then((value) {
      Loading.dismissAll();
    });
  }

  /// 上拉加载回调
  void _onLoading() async {
    viewModel.loadMoreDatas().then((value) {
      _refreshController.loadComplete();
    });
  }

  /// 下拉刷新回调
  void _onRefresh() async {
    viewModel.refreshDatas().then((value) {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefreshWidget(
            controller: _refreshController,
            //上拉时显示的loading效果
            onLoading: _onLoading,
            //上拉加载回调
            onRefresh: _onRefresh,
            //下拉刷新回调
            child: SingleChildScrollView(
              //用于联合 banner和listView 的滑动
              child: Column(children: [
                _banner(),
                _homeListView(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return ListView.builder(
        shrinkWrap: true, //内容适配
        physics: NeverScrollableScrollPhysics(), //禁止滑动
        itemBuilder: (context, index) {
          return _listItemView(vm.homeListItemDatas?[index], index);
        },
        itemCount: vm.homeListItemDatas?.length ?? 0,
      );
    });
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return SizedBox(
        height: 245.h,
        width: double.infinity,
        child: Swiper(
          indicatorLayout: PageIndicatorLayout.NONE,
          autoplay: true,
          pagination: const SwiperPagination(),
          itemCount: vm.bannerList?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                //跳转到网页
                RouteUtils.push(
                    context,
                    WebviewPage(
                      webViewType: WebViewType.URL,
                      loadResource: vm.bannerList?[index]?.url ?? "",
                      showTitle: true,
                      title: vm.bannerList?[index]?.title,
                    ));
              },
              child: Container(
                margin: EdgeInsets.all(10.r),
                child: Image.network(
                  vm.bannerList?[index].imagePath ?? "",
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _listItemView(HomeListItemData? item, int index) {
    String chapterName = formatChapter(item?.superChapterName, item?.chapterName);

    return InkWell(
        onTap: () {
          //跳转到网页
          RouteUtils.push(
              context,
              WebviewPage(
                webViewType: WebViewType.URL,
                loadResource: item?.link ?? "",
                showTitle: true,
                title: item?.title,
              ));
          //RouteUtils.pushForNamed(context, RoutePath.webViewPage, arguments: {"name": "使用路由传值"});
        },
        child: Container(
            margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
            padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.r))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 自己的头像做法
                    CircleAvatar(
                      radius: 15.r,
                      backgroundImage: NetworkImage(
                        "https://resources.ninghao.net/images/candy-shop.jpg",
                      ),
                    ),
                    // 下面的头像做法是B站教程做法
                    /*ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  "https://resources.ninghao.net/images/candy-shop.jpg",
                  width: 30.r,
                  height: 30.r,
                  fit: BoxFit.fill,
                ),
              ),*/
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      item?.author?.isNotEmpty == true ? "开发者: ${item?.author}" : "分享者: ${item?.shareUser}",
                      style: TextStyle(color: Colors.black),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Text(
                        item?.niceShareDate ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 12.sp),
                      ),
                    ),
                    (item?.type?.toInt() == 1)
                        ? Text(
                            '置顶',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  item?.title ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Text(
                      chapterName,
                      style: TextStyle(color: Colors.green, fontSize: 12.sp),
                    ),
                    Expanded(child: SizedBox()),
                    collectImage(item?.collect,width: 30.r,height: 30.r,onTap: (){
                      viewModel.collect("${item?.id}", index);
                    }),
                  ],
                ),
              ],
            )));
  }

  String formatChapter(String? superChapterName, String? chapterName) {
    var name = "开发区";
    if (chapterName != null && chapterName != "") {
      name = chapterName;
    }
    if (superChapterName != null && superChapterName != "") {
      name = "$superChapterName / $name";
    }
    return name;
  }
}
