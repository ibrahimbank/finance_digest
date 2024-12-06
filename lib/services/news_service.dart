import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  static const String apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';
  static const String endpoint =
      'https://finnhub.io/api/v1/news?category=general&token=$apiKey';

  Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((news) => News.fromJson(news)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
