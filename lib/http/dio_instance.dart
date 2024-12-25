import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/http/cookie_interceptor.dart';
import 'package:wanandroid_flutter/http/print_log_interceptor.dart';
import 'package:wanandroid_flutter/http/respose_interceptor.dart';
import 'http_method.dart';

/// @Author          : Symphony
/// @Email           : 95200261@qq.com
/// @Date            : on 2024/12/19 1:10.
/// @Description     : 封装 dio 单例


class DioInstance {
  static DioInstance? _instance;

  // 私有化构造函数
  DioInstance._();

  // 利用get关键字 免去调用时要写"()"
  static DioInstance get instance => _instance ??= DioInstance._();


  final Dio _dio = Dio();
  final _defaultTime = Duration(seconds: 30);

  void initDio({
    required String baseUrl,
    String httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
      responseType: responseType,
      contentType: contentType,
    );
    // 拦截器有先后顺序，要注意
    // 添加 cookie 拦截器
    _dio.interceptors.add(CookieInterceptor());
    // 添加打印请求/返回/错误 信息的拦截器
    _dio.interceptors.add(PrintLogInterceptor());

    // 添加 统一返回值处理拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

  /// get请求封装
  Future<Response> get({
    required String path,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(path,
        queryParameters: params,
        options: options ??
            Options(
              method: HttpMethod.GET,
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
            ),
        cancelToken: cancelToken);
  }

  /// post请求封装
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(path,
        data: data,
        queryParameters: params,
        options: options ??
            Options(
              method: HttpMethod.POST,
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
            ),
        cancelToken: cancelToken);
  }
}
