import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _image;
  Widget result = Text('결과가 이곳에 표시됩니다.'); //3번

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  // 모델을 불러오는 작업
  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //선택하거나 찍은 이미지가 출력되는 곳
          Container(
              margin: EdgeInsets.all(50),
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              child: show()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    getImage(ImageSource.gallery);
                  },
                  child: Icon(Icons.image)),
              SizedBox(width: 40),
              ElevatedButton(
                  onPressed: () async {
                    getImage(ImageSource.camera);
                  },
                  child: Icon(Icons.camera_alt))
            ],
          ),
          //결과가 출력되는곳
          //처음 실행 시 3번 출력
          //ml처리중에는 4번 출력
          //결과가 나오면 5번 출력
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: Center(child: result),
          )
        ],
      ),
    );
  }

  //출력할 이미지 값이 비었을 경우에 1번, 있다면 2번을 리턴시켜서 출력
  Widget show() {
    return Center(
        child: _image == null
            ? Text('No Image Selected') //1번
            : Image.file(File(_image!.path))); //2번
  }

  getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: source);
    setState(() {
      //불러온 이미지를 _image에 넣는다
      _image = File(image!.path);
      result = CircularProgressIndicator(); //4번
    });

    //갤러리에서 불러오거나 카메라로 찍은 이미지가 있을때 ml실행
    if (image != null) mlRun();
  }

  mlRun() async {
    //path에 이미지를 넣어 ml연산을 수행함
    var output = await Tflite.runModelOnImage(
        path: _image!.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    //ml의 결과가 길이가 1인 List<dynamic>형식으로 반환됨
    //리턴되는 dynamic형식을 살펴보면
    //map형식처럼 {'confidence': 1.0, 'index': 0, 'label': 0 Dog}로 출력된다
    //우리가 원하는 값은 '0 Dog'라는 값으므로
    //List의 첫번째 인덱스의 label값을 찾아 출력시킨다.
    //        ㄴoutput[0]    ㄴ['label]  => 합쳐서 output[0]['label']
    setState(() {
      //출력되는 result 위젯을 다음 텍스트로 바꾼다.
      result = Text(output![0]['label'].toString()); //5번
    });
  }
}
