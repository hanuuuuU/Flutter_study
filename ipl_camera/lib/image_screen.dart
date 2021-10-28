import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<ViewImage> createState() => _ViewImage();
}

class _ViewImage extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(
                Icons.auto_fix_normal_outlined,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.download,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.add_to_photos_outlined,
                size: 27,
              ),
              onPressed: () {}),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 290,
                  child: Image.file(
                    File(widget.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            color: Colors.grey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              scrollDirection: Axis.horizontal,
              children: [
                RawMaterialButton(
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
