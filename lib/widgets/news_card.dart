import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(news.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(news.headline),
        subtitle: Text(news.source),
        onTap: () {
          // Add navigation to detailed news page
        },
      ),
    );
  }
}
