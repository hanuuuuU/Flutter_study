import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              onPressed: () async {}),
          IconButton(
              icon: Icon(
                Icons.add_to_photos_outlined,
                size: 27,
              ),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 176,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 290,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
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
