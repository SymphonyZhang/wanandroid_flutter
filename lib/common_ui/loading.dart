import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';


/// 自定义加载圈
class Loading {
  Loading._();

  /// 呼出加载圈
  static Future showLoading() async {
    showToastWidget(
        Container(
          color: Colors.transparent,
          constraints: const BoxConstraints.expand(),
          child: Align(
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.black54),
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ),
        ),
        handleTouch: true,
        duration: const Duration(days: 1));
  }

  /// 隐藏加载圈
  static void dismissAll(){
    dismissAllToast();
  }
}
