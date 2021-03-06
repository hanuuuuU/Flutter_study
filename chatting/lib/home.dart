import 'package:flutter/material.dart';
import 'home_textfield.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  bool isSignUpScreen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Stack(
          children: [
            //배경
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  color: Colors.green[200],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 70),
                        RichText(
                            text: TextSpan(
                                text: 'Welcome',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    color: Colors.white),
                                children: [
                              TextSpan(
                                  text: ' to chatting app',
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ])),
                        SizedBox(height: 5.0)
                      ],
                    )),
                  ),
                )),
            //로그인, 회원가입 컨테이너
            Positioned(
                top: 180,
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: isSignUpScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 0)
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignUpScreen = false;
                      });
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignUpScreen
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                  if (!isSignUpScreen)
                                    Container(
                                      height: 2,
                                      width: 55,
                                      color: Colors.amber,
                                    )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignUpScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      'Sign_up',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignUpScreen
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                    if (isSignUpScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.amber,
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (isSignUpScreen)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    InputInfo(key: ValueKey(1),hint: 'User name',icon: Icons.account_circle),
                                    SizedBox(height: 10),
                                    InputInfo(key: ValueKey(2),hint: 'User email',icon: Icons.email),
                                    SizedBox(height: 10),
                                    InputInfo(key: ValueKey(3),hint: 'password',icon: Icons.password)
                                  ],
                                ),
                              ),
                            ),
                          if (!isSignUpScreen)
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      InputInfo(key: ValueKey(4),hint: 'User email',icon: Icons.account_circle,),
                                      SizedBox(height: 10),
                                      InputInfo(key: ValueKey(5),hint: 'password',icon: Icons.password)
                                    ],
                                  ),
                                ))
                        ],
                      ),
                    ),
                  ),
                )),
            //로그인 버튼
            Positioned(
                top: isSignUpScreen ? 430 : 390,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: (){_tryValidation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade100,
                                  Colors.green.shade200
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1),
                            ]),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ),
                )),
            //구글 로그인 버튼
            Positioned(
                top: MediaQuery.of(context).size.height - 125,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text('or Signup with'),
                    SizedBox(height: 10),
                    TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            maximumSize: Size(155, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.blue.shade100),
                        icon: Icon(Icons.add),
                        label: Text('Google'))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  //모든 textForm의 validate를 작동시킴
  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();

    if(isValid){
      _formKey.currentState!.save();
    }
  }
}
