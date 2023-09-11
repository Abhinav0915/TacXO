import 'package:flutter/material.dart';
import '../util/appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Welcome To TacXo',
        ),
        body: const Center(
          child: Text('Homepage'),
        ));
  }
}
