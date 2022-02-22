import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _info = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    //뒤로가기 방지를 위한 위젯
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            //로그아웃 버튼
            IconButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: _info.snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            var data = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('이름: ${data!['name']}'),
                  Text('이메일: ${data['email']}'),
                  Text('전화번호: ${data['phone']}'),
                ],
              ),
            );
          },
        )
              ),
    );
  }
}
