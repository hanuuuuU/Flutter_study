import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<ViewImage> createState() => _ViewImage();
}

class _ViewImage extends State<ViewImage> {
  void uploading(String path) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM1OTUyOTY1LCJpYXQiOjE2MzU2OTM3NjUsImp0aSI6IjgxNzFlZTJkZTYzYTQwNGI4ZjA5Nzg1ZDUzNDNhYzdjIiwidXNlcl9pZCI6MSwiZW1haWwiOiJhZG1pbkBhZG1pbi5jb20ifQ.6Svn0PCmTphILLwr8JF7eg5QxnRMReNaLK2cfVXoCxQ'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://ipl-main.herokuapp.com/data/images/'));
    request.fields.addAll({
      'useremail': 'admin@admin.com',
      'username': 'admin',
      'desc': 'test upload2'
    });
    request.files.add(await http.MultipartFile.fromPath('image', path));
    print('============================');
    print(path);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    File editImage = File(widget.path);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                //촬영한 이미지
                Container(
                  child: Image.file(
                    File(widget.path),
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
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: RawMaterialButton(
                                  fillColor: Colors.white,
                                  shape: CircleBorder(),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
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
                        onPressed: () {},
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
                          print('dd');

                          final docPath = await getExternalStorageDirectory();
                          print(docPath);
                          final filename = basename(editImage.path);
                          print(filename);
                          try {
                            final localImage =
                                await editImage.copy('${'/Phone/h/'}$filename');
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
                          uploading(editImage.path);
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
