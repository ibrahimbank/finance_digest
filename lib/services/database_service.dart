import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/news.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'news.db'); // Use the same database file
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the 'news' table
        await db.execute(
          '''
          CREATE TABLE news (
            id INTEGER PRIMARY KEY,
            image TEXT,
            source TEXT,
            date TEXT,
            headline TEXT,
            url TEXT
          )
          ''',
        );

        // Create the 'users' table
        await db.execute(
          '''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
          ''',
        );

        await db.insert(
          'users',
          {
            'email': 'default@example.com',
            'password': 'password123',
          },
        );
      },
    );
  }

  // ------- News Table Methods -------

  Future<void> insertNews(News news) async {
    final db = await database;
    await db.insert(
      'news',
      {
        'image': news.image,
        'source': news.source,
        'date': news.date,
        'headline': news.headline,
        'url': news.url,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<News>> getNews() async {
    final db = await database;
    final List<Map<String, dynamic>> newsList = await db.query('news');
    return List.generate(newsList.length, (i) {
      return News(
        image: newsList[i]['image'],
        source: newsList[i]['source'],
        date: newsList[i]['date'],
        headline: newsList[i]['headline'],
        url: newsList[i]['url'],
      );
    });
  }



  // ------- User Table Methods -------

  Future<int> insertUser(String email, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'email': email, 'password': password},
    );
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }
}

void checkDefaultUser() async {
  final dbService = DatabaseService();
  final user = await dbService.getUser('default@example.com');

  if (user != null) {
    print('Default user exists: ${user['email']}');
  } else {
    print('Default user not found.');
  }
}
