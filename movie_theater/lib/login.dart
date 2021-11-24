import 'package:flutter/material.dart';
import 'account.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffED3124),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('images/logo.png')),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: '아이디',
                        hintStyle: TextStyle(fontSize: 12),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(00000000)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(00000000)),
                        ),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: '비밀번호',
                        hintStyle: TextStyle(fontSize: 12),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(00000000)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Color(00000000)),
                        ),
                      )),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Account()));
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[800],
                          decoration: TextDecoration.underline),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.movie,
                    color: Colors.red,
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
