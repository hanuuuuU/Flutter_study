import 'package:flutter/material.dart';
import 'list.dart';
import 'grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('View'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [Lists(), Grids()],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          indicatorWeight: 5,
          labelColor: Colors.green[700],
          unselectedLabelColor: Colors.grey[350],
          tabs: [
            Tab(
              icon: Icon(Icons.menu),
              text: 'ListView',
            ),
            Tab(
              icon: Icon(Icons.window),
              text: 'GridView',
            )
          ],
          controller: controller,
        ),
      ),
    );
  }
}
