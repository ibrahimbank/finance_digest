import 'package:finance_digest/screens/login_page.dart';
import 'package:finance_digest/screens/news_list_screen.dart';
import 'package:finance_digest/screens/register_page.dart';
import 'package:finance_digest/services/database_service.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Verify default user exists
  checkDefaultUser();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => NewsListScreen(),
      },
    );
  }
}
