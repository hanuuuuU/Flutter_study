import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int left = 1;
  int right = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('주사위 굴리기'),
        backgroundColor: Colors.red[300],
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 50),
              child: Row(
                children: [
                  Expanded(child: Image.asset('images/dice$left.png')),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Image.asset('images/dice$right.png')),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                child: Text('굴리기'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[300], minimumSize: Size(100, 40)),
                onPressed: () {
                  setState(() {
                    left = Random().nextInt(6) + 1;
                    right = Random().nextInt(6) + 1;
                  });
                  showToast('Left Dice: $left        Right Dice: $right');
                }),
          ],
        ),
      ),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
}
