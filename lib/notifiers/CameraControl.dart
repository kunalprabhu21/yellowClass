import 'package:camera/camera.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
CameraControl cameraControl(context, {bool listen: true}) =>
    Provider.of<CameraControl>(context, listen: listen);


class CameraControl extends ChangeNotifier {
  CameraController controller;
  List<CameraDescription> cameras;
  bool CamshowFeed = false;
  bool isReady  = false;


  VideoPlayerControl(){
    getCameras();
  }

  set setVisiblity(bool value) {
    controller.initialize();
    if(CamshowFeed == true){
      CamshowFeed = false;
    }else {
      CamshowFeed = true;
    }
    notifyListeners();
  }

  set setCamera(bool value) {
    isReady = value;
    notifyListeners();
  }



  getCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.max);
    await controller.initialize();

    controller.initialize().then((_) {


        controller.lockCaptureOrientation(DeviceOrientation.landscapeRight);
        setCamera = true;
    });

    notifyListeners();
  }




}