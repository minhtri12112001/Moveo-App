import 'package:flutter/material.dart';
import 'package:moveo_app/model/movie_model.dart';
import '../page/movie_detail_page.dart';

class MoviePoster extends StatefulWidget {
  final MovieModel movie;

  MoviePoster({Key? key, required this.movie}) : super(key: key);
  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MovieDetailPage(movie: widget.movie,)))
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.movie.image_url,
              width: 80,
              height: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
