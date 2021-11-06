import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Photo {
  var urlImage;

  Photo({required this.urlImage});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(urlImage: json['urlImage']);
  }
}

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<ViewImage> createState() => _ViewImage();
}

class _ViewImage extends State<ViewImage> {
  File? editImage;
  String? origin;
  List<bool> isPressed = [];
  List<Color> basicColor = [];
  List<String> images = [];
  int counts = 0;
  var list;

  void uploading(String path) async {
    var request = makePost(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM2Mjk3NzU1LCJpYXQiOjE2MzYwMzg1NTUsImp0aSI6IjQ3YTc1MTI2ODRlMjQwY2M5YzUwMGJmMzVjNDdkNGZmIiwidXNlcl9pZCI6MSwiZW1haWwiOiJhZG1pbkBhZG1pbi5jb20ifQ.xlLZrvN5Fz7qVtvcWJ1SnvhzZB1Adm6iWVrW5y5Pyf0',
        'https://ipl-main.herokuapp.com/data/images/');
    request.fields.addAll({
      'useremail': 'admin@admin.com',
      'username': 'admin',
      'desc': 'test upload2'
    });
    request.files.add(await http.MultipartFile.fromPath('image', path));
    print('============================');
    print(path);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void getImageFromServer(String path) async {
    var request = makePost(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM2Mjk3NzU1LCJpYXQiOjE2MzYwMzg1NTUsImp0aSI6IjQ3YTc1MTI2ODRlMjQwY2M5YzUwMGJmMzVjNDdkNGZmIiwidXNlcl9pZCI6MSwiZW1haWwiOiJhZG1pbkBhZG1pbi5jb20ifQ.xlLZrvN5Fz7qVtvcWJ1SnvhzZB1Adm6iWVrW5y5Pyf0',
        'https://ipl-server-ml.herokuapp.com/processing/image/');

    var imag = await ImagePicker().pickImage(source: ImageSource.gallery);
    request.files.add(await http.MultipartFile.fromPath('image', imag!.path));
    // http.StreamedResponse response = await request.send();
    http.StreamedResponse response = await request.send();
    var a = await response.stream.bytesToString();
    print(a);

    var dec = jsonDecode(a);
    for (var img in dec['img_links']) {
      images.add(img);
    }
    origin = images[0];
    images.removeAt(0);
    for (int i = 0; i < images.length; i++) {
      isPressed.add(false);
      basicColor.add(Colors.transparent);
    }
    print(images);
  }

  void sendPerson() async {
    List<int> number = [];
    for (int i = 0; i < isPressed.length; i++) {
      if (isPressed[i] == true) number.add(i);
    }
    print(number);
    var request = makePost(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM2Mjk3NzU1LCJpYXQiOjE2MzYwMzg1NTUsImp0aSI6IjQ3YTc1MTI2ODRlMjQwY2M5YzUwMGJmMzVjNDdkNGZmIiwidXNlcl9pZCI6MSwiZW1haWwiOiJhZG1pbkBhZG1pbi5jb20ifQ.xlLZrvN5Fz7qVtvcWJ1SnvhzZB1Adm6iWVrW5y5Pyf0',
        'https://ipl-server-ml.herokuapp.com/processing/image/mosaic/');
    request.fields.addAll({
      'img_url': '$origin',
      'human_list': '$number',
    });
    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    print(await response.stream.bytesToString());
  }

  Widget makeButton(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('${images[index]}'),
          child: MaterialButton(
            child: Text(
              '',
              style: TextStyle(fontSize: 80),
            ),
            onPressed: () {
              setState(() {
                isPressed[index] = !isPressed[index];
                basicColor[index] == Colors.transparent
                    ? basicColor[index] = Color(0x93272959)
                    : basicColor[index] = Colors.transparent;
              });
              print(isPressed);
            },
            color: basicColor[index],
            shape: CircleBorder(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    editImage = File(widget.path);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Stack(
              children: [
                //촬영한 이미지
                Container(
                  child: Image.file(
                    editImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                //하단 이미지 선택바
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: screenSize.width,
                        height: 100,
                        color: Color(0x33162859),
                        child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return makeButton(index);
                            }),
                      ),
                    ],
                  ),
                ),
                //뒤로가기 버튼
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    heroTag: 'back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 0,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                //수정,저장,업로드 버튼
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //수정
                      FloatingActionButton(
                        heroTag: 'modify',
                        onPressed: () {
                          print('hello');
                          // setState(() {
                          //   counts = 7;
                          // });
                          getImageFromServer(editImage!.path);
                          setState(() {});
                        },
                        elevation: 0,
                        child: Icon(
                          Icons.auto_fix_normal_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      //저장
                      FloatingActionButton(
                        heroTag: 'download',
                        onPressed: () async {
                          setState(() {});
                          print('dd');

                          final docPath = await getExternalStorageDirectory();
                          print(docPath);
                          final filename = basename(editImage!.path);
                          print(filename);
                          try {
<<<<<<< HEAD
                            final localImage = await editImage!
                                .copy('${docPath!.path}/$filename');
=======
                            final localImage =
                                await editImage.copy('${'/Phone/h/'}$filename');
>>>>>>> f6ce91648c69749984ded3c8d725b141dd313823
                            print(localImage);
                          } catch (e) {
                            print(e);
                          }
                        },
                        elevation: 0,
                        child: Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      //업로드
                      FloatingActionButton(
                        heroTag: 'upload',
                        onPressed: () {
                          uploading(editImage!.path);
                        },
                        elevation: 0,
                        child: Icon(
                          Icons.add_to_photos_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 100,
                    right: 0,
                    child: ElevatedButton(
                        onPressed: () {
                          sendPerson();
                        },
                        child: Text('send'))),
                Positioned(
                    bottom: 100,
                    right: 70,
                    child: ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < isPressed.length; i++) {
                            isPressed[i] = true;
                            basicColor[i] = Color(0x93272959);
                          }
                          setState(() {});
                        },
                        child: Text('select all')))
              ],
            ),
          ),
        ],
      ),
    );
  }

  http.MultipartRequest makePost(var token, String address) {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$address'));
    request.headers.addAll(headers);

    return request;
  }
}
