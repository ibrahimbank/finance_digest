import 'package:flutter/material.dart';
import '../models/news.dart';
import '../services/news_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = NewsService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Digest'),
      ),
      body: FutureBuilder<List<News>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return ListTile(
                  leading: Image.network(news.image ?? '', width: 50),
                  title: Text(news.headline),
                  subtitle: Text('${news.source} - ${news.date}'),
                  onTap: () async {
                    if (await canLaunch(news.url)) {
                      await launch(news.url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link')),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
