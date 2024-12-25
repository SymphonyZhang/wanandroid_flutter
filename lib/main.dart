import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/dio_instance.dart';

import 'app.dart';

void main() {
  //Dio 初始化
  DioInstance.instance.initDio(baseUrl: "https://www.wanandroid.com/");
  runApp(const MyApp());
}


