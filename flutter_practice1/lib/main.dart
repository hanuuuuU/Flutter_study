import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practice1',
      // primarySwatch는 주요 사용할 색상과 비슷한 음영의 색들을 기본 색으로 지정
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold 위젯은 앱 화면에 다양한 요소들을 배치하고 그릴 수 있도록 도와주는 빈 도화지 같은 역할
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('카카오'),
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              flutterToast();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/little_tube.jpg'),
                backgroundColor: Colors.green[100],
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/little_apeach.png'),
                  backgroundColor: Colors.pink[100],
                )
              ],
              accountName: Text('Little Tube'),
              accountEmail: Text('tinytube@kakao.com'),
              onDetailsPressed: () {
                print('clicked');
              },
              decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0))),
            ),
            ListTile(
              //시작점에 배치하기 위해 leading 속성 사용
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text('Home'),
              onTap: () {
                print('home clicked');
              },
              //끝에 배치하기 위해 trailing 속성 사용
              trailing: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text('Setting'),
              onTap: () {
                print('Setting clicked');
              },
              trailing: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.black,
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A clicked');
              },
              trailing: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      //가로축 가운데 정렬
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/tube.gif'),
                radius: 60.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[600],
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'TUBE',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'using lightsaber',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'face hero tattoo',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'fire flames',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Divider(
              height: 60.0,
              color: Colors.transparent,
            ),
            Builder(
              builder: (BuildContext ctx) {
                return Center(
                    child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 20.0)),
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Niniz()));
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

void flutterToast() {
  Fluttertoast.showToast(
      msg: '검색중입니다',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[100],
      fontSize: 15.0,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT);
}

class Niniz extends StatelessWidget {
  const Niniz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('니니즈'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              flutterToast();
            },
          ),
        ],
      ),
      //가로축 가운데 정렬
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/jordy.jpg'),
                radius: 60.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[600],
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'JORDY',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'using lightsaber',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'face hero tattoo',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'fire flames',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                )
              ],
            ),
            Divider(
              height: 60.0,
              color: Colors.transparent,
            ),
            Builder(
              builder: (BuildContext ctx2) {
                return Center(
                    child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 20.0)),
                  child: Text('확인'),
                  onPressed: () {
                    ScaffoldMessenger.of(ctx2)
                        .showSnackBar(SnackBar(content: Text('확인')));
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
