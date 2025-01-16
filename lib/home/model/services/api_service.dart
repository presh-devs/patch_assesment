
import 'package:dio/dio.dart';


abstract class BaseApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> getResponse(String url);
}

class ApiService extends BaseApiService {
  final   Dio _dio =Dio();
  
  @override
  Future<dynamic> getResponse(String url, ) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await _dio.get(BaseApiService.baseUrl + url, data: {
        'limit': 50,
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
