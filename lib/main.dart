import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/game.dart';

void main() {
  runApp(const TacXO());
}

class TacXO extends StatefulWidget {
  const TacXO({super.key});

  @override
  State<TacXO> createState() => _TacXOState();
}

class _TacXOState extends State<TacXO> {
  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => const Homepage(),
      '/game': (context) => GamePage(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
