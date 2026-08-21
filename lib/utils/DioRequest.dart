// 基于Dio进行二次封装

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio(); // dio请求对象

  // 基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // 拦截器
    _addInterceptor();
  }

  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (options, handler) {
          handler.next(options);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // http状态吗 200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        // 错误拦截器
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; // data才是我们接口返回的数据
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        // 才认定 http状态和业务状态均正常 就可以正常的放行通过
        return data["result"]; //只要result结果
      }
      throw Exception(data["msg"] ?? "加载数据异常");
    } catch (e) {
      throw Exception(e);
    }
  }
}

// 单例对象
final dioRequest = DioRequest(); // 单例对象

// dio请求工具发出请求  返回的数据 Response<dynamic>.data
// 把所有的接口的data解放出来 拿到真正的数据 要判断业务状态码是不是等于1
