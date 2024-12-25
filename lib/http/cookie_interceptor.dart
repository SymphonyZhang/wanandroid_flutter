import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/constants.dart';
import 'package:wanandroid_flutter/utils/sp_utils.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/23$ 21:26$.
/// @Description     : Cookie 拦截器
class CookieInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 取出本地保存的cookie信息，放到请求头中
    SpUtils.getStringList(Constants.SP_COOKIE_LIST_KEY).then((cookie){
      options.headers[HttpHeaders.cookieHeader] = cookie;
      //handler.next(options);
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.requestOptions.path.contains("user/login")){
      // 获取 cookie 信息
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList= [];
      if(list is List){
        for (String? cookie in list) {
          cookieList.add(cookie.toString());
          print("CookieInterceptor ====================> ${cookie.toString()}");
        }
      }
      SpUtils.saveStringList(Constants.SP_COOKIE_LIST_KEY, cookieList);
    }
    super.onResponse(response, handler);
  }
}