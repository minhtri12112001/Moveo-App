import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget{
  final VideoPlayerController controller;
  const Video({Key? key, required this.controller}) : super(key: key);
  @override
  State<Video> createState() => _VideoState();

}
class _VideoState extends State<Video>{
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        alignment: Alignment.topCenter,
        child: VideoPlayer(widget.controller),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: VideoPlayer(widget.controller)
    if (widget.controller != null && widget.controller.value.isInitialized){
      return Container(
        alignment: Alignment.topCenter,
        child: VideoPlayer(widget.controller),
      );
    }
  }

   */
}