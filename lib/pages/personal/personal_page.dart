import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/auth/login_page.dart';
import 'package:wanandroid_flutter/pages/personal/personal_vm.dart';
import 'package:wanandroid_flutter/resource/assets.dart';
import 'package:wanandroid_flutter/route/route_utils.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  PersonalViewModel viewModel = PersonalViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            _header(() {
              if (viewModel.shouldLogin) {
                RouteUtils.push(context, LoginPage());
              }
            }),
            _item('我的收藏', () {}),
            _item('检查更新', () {}),
            _item('关于我们', () {}),
            Consumer<PersonalViewModel>(builder: (context,vm,child){
              if(vm.shouldLogin){
                return SizedBox();
              }
              return _item('退出账号', () {
                viewModel.logout((value){
                  if(value){
                    RouteUtils.pushAndRemoveUntil(context, LoginPage());
                  }
                });
              });
            })
          ],
        )),
      ),
    );
  }

  Widget _header(GestureTapCallback? onTap) {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(radius: 35.r, backgroundImage: AssetImage(R.imagesLogo)),
          ),
          SizedBox(height: 6.h),
          Consumer<PersonalViewModel>(builder: (context, vm, child) {
            return GestureDetector(
              onTap: onTap,
              child: Text(vm.username ?? "未登录", style: TextStyle(color: Colors.white, fontSize: 13.sp)),
            );
          }),
        ],
      ),
    );
  }

  Widget _item(String title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: double.infinity,
        margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.w),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: TextStyle(color: Colors.black, fontSize: 13.sp),
            ),
            Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
