import 'package:avalia_aula/pages/disciplinas_page.dart';
import 'package:avalia_aula/pages/feedback_page.dart';
import 'package:avalia_aula/pages/splash_page.dart';
import 'package:avalia_aula/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static var URL_SERVIDOR = "https://evert.ldassis.com/"; //WEBSITE IS OFFLINE

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avalia Aula',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/disciplinas': (context) => const DisciplinasPage(),
        '/feedback': (context) => const FeedbackPage(),
      },
    );
  }
}
