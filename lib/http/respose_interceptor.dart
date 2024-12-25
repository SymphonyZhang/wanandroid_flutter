import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wanandroid_flutter/http/base_model.dart';

class ResponseInterceptor extends Interceptor{

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode == 200){
      try{
        var rsp = BaseModel.fromJson(response.data);
        // errorCode = 0 代表执行成功，不建议依赖任何非0的 errorCode.
        // errorCode = -1001 代表登录失效，需要重新登录。
        if(rsp.errorCode == 0){
          //log("Step 2 ========================>");
          if(rsp.data == null){
            //log("Step 2.1 ========================>");
            handler.next(Response(requestOptions: response.requestOptions,data: true));
          }else{
            //log("Step 2.2 ========================>");
            handler.next(Response(requestOptions: response.requestOptions,data: rsp.data));
          }
        }else if(rsp.errorCode == -1){
          showToast(rsp.errorMsg ?? "");
          // 我觉得不应该往下走
          //handler.reject(DioException(requestOptions: response.requestOptions,message: rsp.errorMsg));
          // 教程会往下走
          if(rsp.data == null){
            //log("Step 1.1 ========================>");
            handler.next(Response(requestOptions: response.requestOptions,data: false));
          }else{
            //log("Step 1.2 ========================>");
            handler.next(Response(requestOptions: response.requestOptions,data: rsp.data));
          }
        } else if(rsp.errorCode == -1001){
          //需要登录
          handler.reject(DioException(requestOptions: response.requestOptions,message: "未登录"));
          showToast("请先登录");
        }
      }catch(e){
        handler.reject(DioException(requestOptions: response.requestOptions,message: "$e"));
      }
    }else{
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
    //注意 要把原来的super.onResponse(response, handler); 删除掉
  }
}