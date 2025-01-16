import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class BaseApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> getResponse(String url);
}

class ApiService extends BaseApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: BaseApiService.baseUrl, responseType: ResponseType.json))
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  @override
  Future<dynamic> getResponse(String url, {int? limit}) async {
    try {
      final response =
          await _dio.get(BaseApiService.baseUrl + url, queryParameters: {
        'limit': limit,
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
