import 'package:dio/dio.dart';

class Api {
  static const baseUrl = 'https://hacker-news.firebaseio.com/v0/';
  static Dio dio = Dio();

  static Future<List<int>> getTopStories() async {
    try {
      final response = await dio.get('$baseUrl/topstories.json');
      return List<int>.from(response.data);
    } on DioError catch (e) {
      print('Error getting top stories: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getItem(int id) async {
    try {
      final response = await dio.get('$baseUrl/item/$id.json');
      return response.data;
    } on DioError catch (e) {
      print('Error getting item $id: $e');
      return {};
    }
  }
}
