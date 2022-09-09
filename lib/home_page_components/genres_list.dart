import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'movie_poster.dart';
import '../model/movie_model.dart';

class GenresList extends StatefulWidget {
  final String genre;
  const GenresList({Key? key, required this.genre}) : super(key: key);
  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> {
  List<MovieModel> movies = [];
  void getMoviesByGenre(String genre) async {
    List<MovieModel> firebaseMovies = [];
    FirebaseFirestore.instance.collection("movies")
        .limit(5)
        .where("category", isEqualTo: genre)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        var data = Map<String, Object>.from(result.data());
        MovieModel movie = MovieModel(
            result.id,
            data['movie_name'].toString(),
            data['movie_url'].toString(),
            data['movie_description'].toString(),
            data['image_url'].toString(),
            data['category'].toString(),
            data['youtube_url'].toString()
        );
        firebaseMovies.add(movie);
        movies = firebaseMovies;
        if (!mounted) continue;
        setState(() => {});
      }
    });
  }
  @override
  void initState(){
    super.initState();
    getMoviesByGenre(widget.genre);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return MoviePoster(
              movie: movies[index]
          );
        });
  }
}
