import 'dart:ui';


import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/notifiers/CameraControl.dart';
import 'package:flutterapp/notifiers/VideoPlayerControl.dart';
import 'package:flutterapp/screens/play_toggle.dart';

class LandscapePlayerControls extends StatelessWidget {
  const LandscapePlayerControls(
      {Key key, this.iconSize = 20, this.fontSize = 12})
      : super(key: key);
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final controller = videoControl(context);
    final Camcontroller = cameraControl(context);
    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickCurrentPosition(
                        fontSize: fontSize,
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      FlickTotalDuration(
                        fontSize: fontSize,
                      ),
                      SizedBox(
                        width: 10,
                      ),
//                      FlickSoundToggle(
//                        size: 20,
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: Row(

            children: [
              GestureDetector(
                onTap: () {
                  Camcontroller.setVisiblity = true;
                },
                child: Icon(
                  Icons.video_call,
                  size: 30,
                ),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  controller.pauseVideo();
                  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.portraitUp]);
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}