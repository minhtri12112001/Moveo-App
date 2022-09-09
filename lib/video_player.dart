/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video.dart';
class VideoPlayer extends StatefulWidget{
  const VideoPlayer({Key? key}) : super(key: key);
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();

}
class _VideoPlayerState extends State<VideoPlayer>{
  late VideoPlayerController _controller;
  @override
  void initState(){
    super.initState();
    //_controller = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/moveo-app-333ff.appspot.com/o/Movies'%20Trailer%2FMarvel%20Studios'%20Avengers-%20Endgame%20-%20Official%20Trailer.mp4?alt=media&token=deccbf94-a32f-4a17-8a1a-fbd49db81850")
    //_controller = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/moveo-app-333ff.appspot.com/o/Movies'%20Trailer%2FLa%20La%20Land%20(2016%20Movie)%20Official%20Trailer%20%E2%80%93%20'Dreamers'.mp4?alt=media&token=242c994a-13cc-4959-94e1-487dfc5f0100")
    _controller = VideoPlayerController.asset("assets/Marvel_Endgame.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
    }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Video(controller: _controller);
  }

}

 */