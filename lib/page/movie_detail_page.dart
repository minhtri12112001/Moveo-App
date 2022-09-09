import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/main.dart';
import 'package:moveo_app/model/movie_model.dart';
import 'package:moveo_app/page/watching_movie_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModel movie;
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.movie.youtube_url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );
  }

  String? movieId;
  void _addMovieToMyList() async {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(widget.movie.id)
        .set({
      "movie_name": widget.movie.movie_name,
      "image_url": widget.movie.image_url,
      "movie_description": widget.movie.movie_description,
      "movie_url": widget.movie.movie_url,
      "category": widget.movie.category,
      "youtube_url": widget.movie.youtube_url
    });
    setState(() {});
  }

  void _deleteMovieToMyList() async {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(widget.movie.id)
        .delete();
    movieId = null;
    setState(() {});
  }

  ///*
  Widget _buildMyListIcon() {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(widget.movie.id)
        .get()
        .then((value) {
      if (value.exists == true) {
        movieId = value.id;
      }

      //print(movieId);
      //print(value.exists);
      if (mounted) {
        setState(() {});
      }
    });
    if (movieId == null) {
      return TextButton(
        style: TextButton.styleFrom(
          primary: Colors.grey,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          _addMovieToMyList();
        },
        child: Column(
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: const Text(
                "My List",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return TextButton(
        style: TextButton.styleFrom(
          primary: Colors.grey,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          _deleteMovieToMyList();
        },
        child: Column(
          children: [
            const Icon(
              Icons.check,
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: const Text(
                "My List",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  //*/

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: youtubePlayerController,
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              //title: Text(widget.movie.image_url),
            ),
            body: ListView(
              children: [
                player,
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.movie.movie_name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  children: const [
                                    Expanded(
                                      flex: 1,
                                      child: Text("1972"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text("18+"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text("2h 55m"),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(widget.movie.movie_description),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Starring: Marlon Brando, Al Pachino, James Caan, ...",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Director: Francis Ford Coppola",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WatchingMoviePage(movie_url: widget.movie.movie_url,)))
                          },
                          style: TextButton.styleFrom(
                              primary: Colors.grey,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              Text(
                                "Play",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildMyListIcon(),
                            ),
                            Expanded(
                                child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.grey,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: const Text(
                                      "Rate",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.grey,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: const Text(
                                      "Share",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.grey,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: const Text(
                                      "Download",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
