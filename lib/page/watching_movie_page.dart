import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../landscape_player_controls.dart';
import 'package:flutter/services.dart';
class WatchingMoviePage extends StatefulWidget {
  final String movie_url;
  const WatchingMoviePage({Key? key, required this.movie_url}) : super(key: key);
  @override
  State<WatchingMoviePage> createState() => _WatchingMoviePageState();
}

class _WatchingMoviePageState extends State<WatchingMoviePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LandscapePlayer(),
    );
  }
}

///*
class LandscapePlayer extends StatefulWidget {
  const LandscapePlayer({Key? key}) : super(key: key);

  @override
  _LandscapePlayerState createState() => _LandscapePlayerState();
}

class _LandscapePlayerState extends State<LandscapePlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
            //VideoPlayerController.network("https://mega.nz/file/EvwglZgT#G5VArJOy9OiVYGUx3H5Rqiekd-Gtb_Jfv8aMZMsfaqU"),
            //VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/moveo-app-333ff.appspot.com/o/Movies'%20Trailer%2FMarvel%20Studios'%20Avengers-%20Endgame%20-%20Official%20Trailer.mp4?alt=media&token=deccbf94-a32f-4a17-8a1a-fbd49db81850")
            VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/moveo-app-333ff.appspot.com/o/Movies'%20Trailer%2FLa%20La%20Land%20(2016%20Movie)%20Official%20Trailer%20%E2%80%93%20'Dreamers'.mp4?alt=media&token=242c994a-13cc-4959-94e1-487dfc5f0100")

        );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(
          flickManager: flickManager,
        ///*
        preferredDeviceOrientation: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],

         //*/
        systemUIOverlay: [],
        flickVideoWithControls: const FlickVideoWithControls(
          controls: const LandscapePlayerControls(),
        ),
      ),
    );
  }
}

//*/
