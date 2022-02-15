import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdsc_login_test/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final pwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
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
                    )
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: TextButton(child: Text('회원가입'),onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                  },),
                ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: (){
                    signIn(emailController.text, pwController.text);},
                  child: Icon(Icons.forward),
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                ))
          ],
        ),
      ),
    );
  }
  //login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try{
        final info = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      print(info);
      }catch(e){Fluttertoast.showToast(msg: e.toString());}
    }
  }
  
}
