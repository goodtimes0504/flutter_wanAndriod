import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/http/base_model.dart';
import 'package:oktoast/oktoast.dart';

// errorCode = 0 代表执行成功，不建议依赖任何非0的 errorCode.
// errorCode = -1001 代表登录失效，需要重新登录。

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response详情：');
    debugPrint('状态码：${response.statusCode}');
    debugPrint('状态消息：${response.statusMessage}');
    debugPrint('请求头：${response.headers}');
    debugPrint('响应数据：${response.data}');
    debugPrint('请求配置：${response.requestOptions.uri}');
    debugPrint('响应类型：${response.runtimeType}');
    debugPrint('额外信息：${response.extra}');
    if (response.statusCode == 200) {
      try {
        // 把返回的json数据转换为BaseModel对象
        var result = BaseModel.fromJson(response.data);
        if (result.errorCode == 0) {
          if (result.data == null) {
            handler.next(Response(
                requestOptions: response.requestOptions,
                data: true,
                statusCode: 200,
                statusMessage: "success"));
          } else {
            handler.next(response);
          }
        } else if (result.errorCode == -1001) {
          showToast("未登录,请先登录");
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: result.errorMsg,
            ),
          );
        } else if (result.errorCode == -1) {
          showToast("${result.errorMsg}");
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: result.errorMsg,
            ),
          );
        } else {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: result.errorMsg,
            ),
          );
        }
      } catch (e) {
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: "数据解析错误",
          ),
        );
      }
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: "网络请求失败",
        ),
      );
    }
  }
}
// import 'package:dio/dio.dart';
// import 'package:flutter_application_11/http/base_model.dart';
// import 'package:oktoast/oktoast.dart';

// ///处理返回值拦截器
// class RspInterceptor extends Interceptor {
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     //修改未登录的错误码为-1001，其他错误码为-1，成功为0，建议对errorCode 判断当不为0的时候，均为错误。
//     if (response.statusCode == 200) {
//       //蒲公英的接口不做处理
//       if (response.requestOptions.path.contains("apiv2/app/check")) {
//         handler.next(response);
//       } else {
//         var rsp = BaseModel.fromJson(response.data);
//         if (rsp.errorCode == 0) {
//           if (rsp.data == null) {
//             handler.next(
//                 Response(requestOptions: response.requestOptions, data: true));
//           } else {
//             handler.next(Response(
//                 requestOptions: response.requestOptions, data: rsp.data));
//           }
//         } else if (rsp.errorCode == -1001) {
//           handler.reject(DioException(
//               requestOptions: response.requestOptions, message: "未登录"));
//           showToast("请先登录");
//         } else {
//           handler.reject(DioException(requestOptions: response.requestOptions));
//         }
//       }
//     } else {
//       handler.reject(DioException(requestOptions: response.requestOptions));
//     }
//   }
// }
