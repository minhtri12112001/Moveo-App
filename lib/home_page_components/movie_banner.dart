import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/model/movie_model.dart';
import 'package:moveo_app/page/movie_detail_page.dart';

import '../main.dart';
import '../page/watching_movie_page.dart';

class MovieBanner extends StatefulWidget {
  const MovieBanner({Key? key}) : super(key: key);

  @override
  State<MovieBanner> createState() => _MovieBannerState();
}

class _MovieBannerState extends State<MovieBanner> {
  MovieModel? movie;
  String? movieId;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("movies")
        .orderBy("views", descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        var data = Map<String, Object>.from(result.data());
        movie = MovieModel(
            result.id,
            data['movie_name'].toString(),
            data['movie_url'].toString(),
            data['movie_description'].toString(),
            data['image_url'].toString(),
            data['category'].toString(),
            data['youtube_url'].toString());
        if (!mounted) continue;
        setState(() => {});
      }
    });
  }

  void _addMovieToMyList() {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(movie?.id)
        .set({
      "movie_name": movie?.movie_name,
      "image_url": movie?.image_url,
      "movie_description": movie?.movie_description,
      "movie_url": movie?.movie_url,
      "category": movie?.category,
      "youtube_url": movie?.youtube_url
    });
    setState(() {});
  }

  void _deleteMovieToMyList() {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(movie?.id)
        .delete();
    movieId = null;
    setState(() {});
  }

  Widget _buildMyListIcon() {
    FirebaseFirestore.instance
        .collection("/users/${MyApp.user.userId}/myList")
        .doc(movie?.id)
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
              size: 30,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
                "My List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white,
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
              size: 30,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
                "My List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
  Future<String> getImageUrl(movie) async {
    return await movie.image_url;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///*
        SizedBox(
          height: 500,
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              (movie == null) ? "https://play-lh.googleusercontent.com/TBRwjS_qfJCSj1m7zZB93FnpJM5fSpMA_wUlFDLxWAb45T9RmwBvQd5cWR5viJJOhkI" : movie!.image_url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 400),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildMyListIcon(),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: TextButton(
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WatchingMoviePage(movie_url: movie!.movie_url,)))
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.grey,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      /*
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie!)));

                       */
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text(
                            "Info",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          )
        )
      ],
    );
  }
}
