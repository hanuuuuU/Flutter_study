import 'package:flutter/material.dart';
import 'dice.dart';
import 'otherLogin.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: Code(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(60)),
                Center(
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    width: 150,
                    height: 150,
                  ),
                ),
                Form(
                    child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.teal,
                            inputDecorationTheme: InputDecorationTheme(
                                labelStyle: TextStyle(
                                    color: Colors.teal, fontSize: 20))),
                        child: Container(
                          padding: EdgeInsets.all(50),
                          child: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(labelText: 'ID'),
                                keyboardType: TextInputType.emailAddress,
                                controller: controller,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: controller2,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OtherLogin()));
                                  },
                                  child: Text('다른 계정으로 로그인')),
                              ElevatedButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green[800],
                                    minimumSize: Size(70, 40)),
                                onPressed: () {
                                  if (controller.text == 'hanu' &&
                                      controller2.text == '0000') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Dice()));
                                  } else {
                                    showSnackBar(context);
                                  }
                                },
                              )
                            ],
                          ),
                        )))
              ],
            ),
          ),
        );
      }),
    );
  }
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '아이디 또는 비밀번호를 다시 입력해주세요.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
  ));
}
