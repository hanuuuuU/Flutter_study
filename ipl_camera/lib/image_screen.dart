import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<ViewImage> createState() => _ViewImage();
}

class _ViewImage extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                        onPressed: () async {
                          await ImageGallerySaver.saveFile(widget.path);
                          Fluttertoast.showToast(
                              msg: '저장되었습니다.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white);
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
                        onPressed: () {},
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
