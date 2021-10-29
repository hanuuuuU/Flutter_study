import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipl_camera/image_screen.dart';
import 'package:ipl_camera/video_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  double left1 = 0;
  double left2 = 78;
  double right1 = 156;
  bool onRec = false;
  var recording = Icons.circle_outlined;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    //카메라 화면 보여주기
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Container(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: left1,
                      color: Colors.transparent,
                    ),
                    Container(
                      width: left2,
                      color: Colors.transparent,
                    ),
                    Container(
                      width: 80,
                      color: Colors.transparent,
                      child: RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              left1 = 78;
                              left2 = 78;
                            });
                          },
                          elevation: 0,
                          fillColor: Colors.transparent,
                          child: Icon(
                            Icons.circle,
                            size: 70,
                            color: Colors.pink[100],
                          ),
                          shape: CircleBorder()),
                    ),
                    Container(
                      width: 80,
                      color: Colors.transparent,
                      child: RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              left1 = 78;
                              left2 = 0;
                            });
                          },
                          elevation: 0,
                          fillColor: Colors.transparent,
                          child: Icon(
                            Icons.circle,
                            size: 70,
                            color: Colors.white,
                          ),
                          shape: CircleBorder()),
                    ),
                    Container(
                      width: 80,
                      color: Colors.transparent,
                      child: RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              left1 = 0;
                              left2 = 0;
                            });
                          },
                          elevation: 0,
                          fillColor: Colors.transparent,
                          child: Icon(
                            Icons.circle,
                            size: 70,
                            color: Colors.red,
                          ),
                          shape: CircleBorder()),
                    ),
                    Container(
                      width: right1,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () async {
                  if (left1 == 78 && left2 == 78) {
                    print('Live');
                  } else if (left1 == 78 && left2 == 0) {
                    try {
                      // Ensure that the camera is initialized.
                      await _initializeControllerFuture;

                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      final image = await _controller.takePicture();

                      // If the picture was taken, display it on a new screen.
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewImage(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            path: image.path,
                          ),
                        ),
                      );
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  } else if (left1 == 0 && left2 == 0) {
                    await _initializeControllerFuture;

                    if (!onRec) {
                      print('Recording Video');

                      await _controller.startVideoRecording();
                      setState(() {
                        recording = Icons.radio_button_on_outlined;
                        onRec = true;
                      });
                    } else {
                      print('Stop recording');
                      XFile videopath = await _controller.stopVideoRecording();
                      setState(() {
                        recording = Icons.circle_outlined;
                        onRec = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewVideo(path: videopath.path)));
                    }
                  }
                },
                elevation: 2.0,
                fillColor: Colors.transparent,
                child: Icon(
                  recording,
                  size: 80,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
              )
            ],
          )
        ],
      ),
    );
  }
}
