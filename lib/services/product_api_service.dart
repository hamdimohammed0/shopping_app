import 'package:dio/dio.dart';

class ProductApiService {
  final Dio dio;

  ProductApiService(this.dio);

  Future<List<dynamic>> getProducts() async {
    try {
      final response = await dio.get('https://dummyjson.com/products');

      return response.data['products'];

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('API key is invalid');
      }

      if (e.response?.statusCode == 429) {
        throw Exception('Too many requests');
      }

      if (e.type == DioExceptionType.connectionError) {
        throw Exception('NO internet connection');
      }

      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
