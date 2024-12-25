import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/hot_key/hot_key_vm.dart';
import 'package:wanandroid_flutter/repository/datas/common_website_data.dart';
import 'package:wanandroid_flutter/repository/datas/search_hot_keys_data.dart';
import 'package:wanandroid_flutter/resource/assets.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';
import 'package:wanandroid_flutter/route/routes.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyViewModel viewModel = HotKeyViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initHotKeyPageData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  // 热词标题
                  _itemTabBar('搜索热词',iconAsset: R.imagesIconSearch),
                  //搜索热词
                  _hotKeyGridView(),
                  // 常用网站列表标题
                  _itemTabBar('常用网站'),
                  // 常用网站
                  _websiteGridView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemTabBar(String name, {String? iconAsset}) {
    return Container(
      height: 45.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5.r, color: Colors.grey),
          bottom: BorderSide(width: 0.5.r, color: Colors.grey),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(top: (iconAsset != null) ? 0.5.h : 20.h),
      child: (iconAsset != null)
          ? Row(
              children: [
                Text(name, style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                Expanded(child: SizedBox()),
                Image.asset(R.imagesIconSearch, width: 30.r, height: 30.r),
              ],
            )
          : Text(name, style: TextStyle(fontSize: 14.sp, color: Colors.black)),
    );
  }

  Widget _hotKeyGridView() {
    return Consumer<HotKeyViewModel>(
      builder: (context, value, child) {
        return _gridView(
            hotKeyList: viewModel.hotKeyList,
            hotkeyTap: (value) {
              //TODO 搜索热词点击操作
              showToast(value);
            });
      },
    );
  }

  Widget _websiteGridView() {
    return Consumer<HotKeyViewModel>(
      builder: (context, value, child) {
        return _gridView(
            websiteList: viewModel.websiteList,
            websiteTap: (value) {
              RouteUtils.pushForNamed(context, RoutePath.webViewPage, arguments: {"name": value.name ?? ""});
            });
      },
    );
  }

  Widget _gridView({List<SearchHotKeysData>? hotKeyList, List<CommonWebsiteData>? websiteList, ValueChanged<String>? hotkeyTap, ValueChanged<WebsiteSimpleInfo>? websiteTap}) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GridView.builder(
        shrinkWrap: true,
        //内容适配
        physics: NeverScrollableScrollPhysics(),
        //禁止滑动
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 最大主轴范围
          maxCrossAxisExtent: 120.w,
          //主轴的间隔
          mainAxisSpacing: 8.h,
          //交叉轴的间隔
          crossAxisSpacing: 8.w,
          //宽高比
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          if (hotKeyList != null) {
            return _item(hotKeyList[index].name, hotkeyTap: hotkeyTap);
          }
          return _item(websiteList?[index].name, websiteTap: websiteTap, link: websiteList?[index].link);
        },
        itemCount: hotKeyList == null ? websiteList?.length ?? 0 : hotKeyList.length ?? 0,
      ),
    );
  }

  Widget _item(String? name, {ValueChanged<String>? hotkeyTap, ValueChanged<WebsiteSimpleInfo>? websiteTap, String? link}) {
    return GestureDetector(
      onTap: () {
        if (link != null) {
          //website
          WebsiteSimpleInfo websiteSimpleInfo = WebsiteSimpleInfo();
          websiteSimpleInfo.name = name;
          websiteSimpleInfo.link = link;
          websiteTap?.call(websiteSimpleInfo);
        } else {
          //hotkey
          hotkeyTap?.call(name ?? "");
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          border: Border.all(color: Colors.grey, width: 0.5.r),
        ),
        child: Text(
          name ?? "",
          style: TextStyle(fontSize: 10.sp),
        ),
      ),
    );
  }
}
