import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
      title: 'movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: Main()));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
