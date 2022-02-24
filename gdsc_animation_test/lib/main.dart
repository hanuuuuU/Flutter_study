import 'package:flutter/material.dart';
import 'slivers_screen.dart';
import 'animated_builder_screen.dart';
import 'hero_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter_study'),
      ),
      body: Center(
        child: Column(
					mainAxisAlignment: MainAxisAlignment.center, 
					children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SliversScreen()),
              );
            },
            child: Text('SliversScreen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimatedBuilderScreen()),
              );
            },
            child: Text('AnimatedBuilderScreen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HeroScreen()),
              );
            },
            child: Text('HeroScreen'),
          )
        ]),
      ),
    );
  }
}