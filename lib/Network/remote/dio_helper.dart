import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init() {
      dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/'  ,
          receiveDataWhenStatusError:true  ,
          )
      ) ;
}
  static Future<Response> getData({
    required String methodUrl ,
    required Map<String,dynamic> query,
  }) async {
    return dio!.get(
      methodUrl ,
      queryParameters: query ,
    ) ;
  }

}