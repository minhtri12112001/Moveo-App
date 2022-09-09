import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/home_page_components/movie_poster.dart';
import 'package:moveo_app/page/search_page.dart';
import '../home_page_components/custom_app_bar.dart';
import '../main.dart';
import 'movie_detail_page.dart';
import '../model/movie_model.dart';
import 'dart:math' as math;
class MovieListPage extends StatefulWidget {
  final String search_key;
  MovieListPage({Key? key, required this.search_key}) : super(key: key);
  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<MovieModel> movies = [];
  int count = 0;
  void _getMovieList() {
    List<MovieModel> firebase_movies = [];
    FirebaseFirestore.instance
        .collection("movies")
        .where("category", isEqualTo: widget.search_key)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var data = Map<String, Object>.from(result.data());
        count++;
        MovieModel movie = MovieModel(
            result.id,
            data['movie_name'].toString(),
            data['movie_url'].toString(),
            data['movie_description'].toString(),
            data['image_url'].toString(),
            data['category'].toString(),
            data['youtube_url'].toString()
        );
        //print(data);
        firebase_movies.add(movie);
        movies = firebase_movies;
        setState(()=>{});
      });
    });
    //_getMovieList();
  }
  Widget _buildUserIcon() {
    if (MyApp.user.userImage == null){
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          "https://www.kindpng.com/picc/m/193-1930135_flat-user-icon-hd-png-download.png",
          fit: BoxFit.cover,
        ),
      );
    }
    else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          MyApp.user.userImage as String,
          fit: BoxFit.cover,
        ),
      );
    }
    setState(() => {});
  }
  @override
  Widget build(BuildContext context) {
    _getMovieList();
    print(movies.length);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: const Icon(Icons.search),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              height: 30,
              child: _buildUserIcon(),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Text(
                    widget.search_key,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: Icon(
                    size: 30,
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          children: [
            Container(
              child: Text(widget.search_key),
            ),
            GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: (1 / 2),
                  ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movies[index],)))
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          height: 150,
                          fit: BoxFit.cover,
                          movies[index].image_url,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          movies[index].movie_name,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                          ),
                        ),
                      )
                    ],
                  )
                );
              },
              itemCount: movies.length,
            )
          ],
        ));
  }
}
