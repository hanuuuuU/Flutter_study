import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 75, 25, 0),
                    child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType
                            .emailAddress, //이메일의 경우 이메일 형식으로 쓰이도록 함.
                        validator: (value) {
                          //reg expression for email validation
                          if (value!.isEmpty ||
                              !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                            // return ("Please Enter a valid email");
                            return ("잘못된 이메일 형식입니다.");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next, //엔터 치면 다음으로 넘어감
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
                    child: TextFormField(
                      autofocus: false,
                      controller: pwController,
                      obscureText: true, //비밀번호 비밀로 칠 수 있게 해줌
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          // return ("Password is required for login");
                          return ("로그인을 위해 비밀번호가 필요합니다.");
                        }
                        if (!regex.hasMatch(value)) {
                          // return ("Enter Valid Password(Min. 6 Character");
                          // return ("유효한 비밀번호(최소 6자)를 입력하십시오.");
                          return ("비밀번호를 잘못 입력하셨습니다."); //6자 이상 입력해도 틀리면 사용자가 없다고 문구가 뜨긴하는데.. 그리고 if문이 6자 이상 안쳤을때 나오는 문구라..고민중
                        }
                      },
                      onSaved: (value) {
                        pwController.text = value!;
                      },
                      textInputAction: TextInputAction.done, //엔터쳤을 떄 다음으로 안넘어감
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "PassWord",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
                    child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType
                            .emailAddress, //이메일의 경우 이메일 형식으로 쓰이도록 함.
                        validator: (value) {
                          //reg expression for email validation
                          if (value!.isEmpty ||
                              !RegExp("^[a-zA-Z0-9]").hasMatch(value)) {
                            // return ("Please Enter a valid email");
                            return ("사용할 수 없는 이름입니다.");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next, //엔터 치면 다음으로 넘어감
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
                    child: TextFormField(
                        controller: phoneController,
                        keyboardType:
                            TextInputType.phone, //이메일의 경우 이메일 형식으로 쓰이도록 함.
                        validator: (value) {
                          //reg expression for email validation
                          if (value!.isEmpty ||
                              value.length != 11 ||
                              !RegExp("^[0-9]").hasMatch(value)) {
                            // return ("Please Enter a valid email");
                            return ("잘못된 번호 형식입니다.");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next, //엔터 치면 다음으로 넘어감
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "PhoneNumber",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () {
                      signUp(emailController.text, pwController.text);
                    },
                    child: Text('가입하기')))
          ],
        ),
      ),
    ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Fluttertoast.showToast(msg: '계정 생성이 완료되었습니다.');
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void registerDetails() {
    //firestore database에 현재 등록 유저의 정보 올리기
  }
}
