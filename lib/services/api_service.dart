import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class ApiService {
  static const String _apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';
  static const String _baseUrl = 'https://finnhub.io/api/v1/news?category=general';

  static Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl&token=$_apiKey'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => News.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      rethrow;
    }
  }
}
