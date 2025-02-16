import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resource/assets.dart';

/// 标题文本15号、黑色
TextStyle titleTextStyle15 = TextStyle(color: Colors.black,fontSize: 15.sp);

/// 普通字体、只做判空处理
Widget normalText(String? text){
  return Text(text ?? "",style: titleTextStyle15,);
}

/// 通用白色圆角边框按钮
Widget commonRadiusButton({required String text, GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45.h,
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.r),
        borderRadius: BorderRadius.all(Radius.circular(22.5.r)),
      ),
      child: Text(
        text ?? "",
        style: TextStyle(color: Colors.white, fontSize: 20.sp),
      ),
    ),
  );
}

/// 通用白色圆角输入框
Widget commonInputTextField({String? labelText, TextEditingController? controller, ValueChanged<String>? onChanged}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(color: Colors.white, fontSize: 14.sp),
    maxLines: 1,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      labelText: labelText ?? "请输入",
      labelStyle: TextStyle(color: Colors.white),
      // 为获取焦点前
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.w),
      ),
      // 获取焦点后
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5.w),
      ),
    ),
  );
}

Widget collectImage(bool? collect,{double? width,double? height,GestureTapCallback? onTap}){
  return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        (collect ?? false) ? R.imagesImgCollect : R.imagesImgCollectGrey,
        width: width ?? 25.r,
        height: height ?? 25.r,
      ));
}
