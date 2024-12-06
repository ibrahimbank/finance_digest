class News {
  final String image;
  final String source;
  final String date;
  final String headline;
  final String url;

  News({
    required this.image,
    required this.source,
    required this.date,
    required this.headline,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      image: json['image'].toString() ?? '',
      source: json['source'].toString() ?? '',
      date: json['datetime'].toString() ?? '',
      headline: json['headline'].toString() ?? '',
      url: json['url'].toString() ?? '',
    );
  }
}
