import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? id;
  String? password;
  String? name;
  String? phoneNumber;
  String? cardNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 120, 50, 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '회원가입',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                selectData('아이디', id),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 50,
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintStyle: TextStyle(fontSize: 15),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                selectData('이름', name),
                SizedBox(
                  height: 20,
                ),
                selectData('전화번호', phoneNumber),
                SizedBox(
                  height: 20,
                ),
                selectData('카드번호', cardNumber),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectData(String hint, String? info) {
    return Container(
      width: 300,
      height: 50,
      child: TextField(
          style: TextStyle(color: Colors.black, fontSize: 15),
          decoration: InputDecoration(
            labelText: hint,
            fillColor: Colors.white,
            filled: true,
          )),
    );
  }
}
