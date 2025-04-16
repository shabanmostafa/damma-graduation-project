// import 'package:dio/dio.dart';
// import 'package:doctor_hunt/core/api/endpoints.dart';
// import 'package:doctor_hunt/core/cache/cache_helper.dart';

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers[ApiKey.token] =
//         CacheHelper().getData(key: ApiKey.token) != null
//             ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
//             : null;
//     super.onRequest(options, handler);
//   }
// }
