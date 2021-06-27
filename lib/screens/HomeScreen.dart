import 'package:camera/camera.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/notifiers/CameraControl.dart';
import 'package:flutterapp/notifiers/VideoPlayerControl.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'landscape_player_controls.dart';

class MyHomePage extends StatefulWidget {
  List<CameraDescription> cameras;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  DragController dragController = DragController();


  @override
  void initState() {
    super.initState();
    videoControl(context, listen: false).initailzeVideo();
    cameraControl(context, listen: false).getCameras();
  }

  @override
  void dispose() {
    cameraControl(context, listen: false).controller?.dispose();
    videoControl(context, listen: false).flickManager.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final controller = videoControl(context);
    final Camcontroller = cameraControl(context);
    final size = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        controller.pauseVideo();
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: controller.flickManager,
              preferredDeviceOrientation: [
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft
              ],
              systemUIOverlay: [

              ],
              flickVideoWithControls: FlickVideoWithControls(
                controls: LandscapePlayerControls(),
              ),
            ),
            DraggableWidget(
              normalShadow: BoxShadow(color: Colors.transparent),
              draggingShadow: BoxShadow(color: Colors.transparent),
              shadowBorderRadius: 1,
              dragController: dragController,
                    child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(child: Container(
                      width: 120,
                      height: 100,
                      child: ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              width: size,

                              child:   Visibility(
                                  visible: Camcontroller.CamshowFeed,
                                  child: CameraPreview(Camcontroller.controller)), // this is my CameraPreview
                            ),
                          ),
                        ),
                      ),
                    ),)),
              ),
            ),
            Column(
              children: [

                Row(

                  children: [

                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(math.pi),
                      child: new Container(
                        margin: EdgeInsets.only(top: 100,bottom: 100,left: 10),
                        color: Colors.black,
//                    height: 100,
//                    width: 50,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            value: controller.currentSliderValue,
                            min: 0.0,
                            max: 1.0,
                            divisions: 9,
                            onChanged: (double value) {
                              setState(() {
                                controller.currentSliderValue = value;
                                controller.controlVolume(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            )

          ],

        ),
      ),
    );
  }
}




