import 'package:dio/dio.dart';
import 'package:flutter_application_11/http/http_method.dart';
import 'package:flutter_application_11/http/print_log_interceptor.dart';
import 'package:flutter_application_11/http/response_interceptor.dart';
import 'package:flutter_application_11/http/cookie_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance getInstance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTime = const Duration(seconds: 30);
  // "https://www.wanandroid.com/"
  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod ?? HttpMethod.GET,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? "application/json; charset=utf-8",
    );
    // 添加cookie拦截器
    _dio.interceptors.add(CookieInterceptor());
    // 添加打印请求返回信息拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    // 添加统一返回值处理拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

// 封装的get请求
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? param,
      Options? options,
      CancelToken? cancelToken}) async {
    return await _dio.get(path,
        queryParameters: param,
        options: options ??
            Options(
              method: HttpMethod.GET,
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
            ),
        cancelToken: cancelToken);
  }

  // 封装的post请求
  Future<Response> post(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    return await _dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              method: HttpMethod.POST,
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
            ),
        cancelToken: cancelToken);
  }
}
