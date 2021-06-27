import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
VideoPlayerControl videoControl(context, {bool listen: true}) =>
    Provider.of<VideoPlayerControl>(context, listen: listen);


class VideoPlayerControl extends ChangeNotifier {
  FlickManager flickManager;
  VideoPlayerController _controller;
  double currentSliderValue = 0.0;


  VideoPlayerControl(){
    initailzeVideo();
  }

  initailzeVideo(){
    _controller = VideoPlayerController.network('https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/rio_from_above_compressed.mp4?raw=true',);
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController:
      _controller,
    );
    _controller.setVolume(0.0);
  }

  controlVolume(double volume){

    _controller.setVolume(volume);

    notifyListeners();
  }

  pauseVideo(){


    _controller.pause();

    notifyListeners();
  }

}