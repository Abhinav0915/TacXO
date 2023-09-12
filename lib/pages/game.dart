import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/appbar.dart';
import '../pages/homepage.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'TacXO',
      ),
      body: Center(
        child: Text("Welcome, "),
      ),
    );
  }
}
