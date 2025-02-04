import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_11/constants.dart';
import 'package:flutter_application_11/utils/sp_utils.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 取出本地cookie 放到请求头里
    SpUtils.getStringList(Constants.SP_COOKIE_LIST).then((value) {
      if (value != null) {
        options.headers[HttpHeaders.cookieHeader] = value;
      }
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path == 'user/login') {
      // 登录成功后，保存cookie
      var cookie = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookiesList = [];

      if (cookie != null) {
        for (var item in cookie) {
          cookiesList.add(item);
          print('拦截器cookie: ${item.toString()}');
        }
      }
      SpUtils.saveStringList(Constants.SP_COOKIE_LIST, cookiesList);
    }
    super.onResponse(response, handler);
  }
}
