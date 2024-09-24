import 'package:dio/dio.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:get/get.dart' as getx;

class DioService {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'lang': CacheNetwork.getCache('lang')  ?? getx.Get.deviceLocale.toString(),
    },
  ));

  DioService() {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler)  {
        String? token =  CacheNetwork.getCache('token');
        print('here $token');
        if (token != null) {
          options.headers['Authorization'] = token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401) {
          CacheNetwork.removeCache('token');
        }
        
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          CacheNetwork.removeCache('token');
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String endpoint, Map<String, String> body) async {
    return await _dio.post(
      endpoint,
      data: body,
    );
  }

  Future<Response> get(String endpoint) async {
    return await _dio.get(
      endpoint,
    );
  }
}