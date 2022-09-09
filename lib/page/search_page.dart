import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../current_page.dart';
import '../main.dart';
import '../model/movie_model.dart';
import 'movie_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<MovieModel> movies = [];
  List<MovieModel> shown_movies = [];

  @override
  void initState() {
    super.initState();
    _getMovieList();
  }

  void _getMovieList() {
    List<MovieModel> firebaseMovies = [];
    FirebaseFirestore.instance.collection("movies").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        var data = Map<String, Object>.from(result.data());
        MovieModel movie = MovieModel(
            result.id,
            data['movie_name'].toString(),
            data['movie_url'].toString(),
            data['movie_description'].toString(),
            data['image_url'].toString(),
            data['category'].toString(),
            data['youtube_url'].toString());
        firebaseMovies.add(movie);
        movies = firebaseMovies;
        if (!mounted) continue;
        setState(() => {});
      }
    });
  }

  void _returnSearchedMovies(String? value) {
    if (value != null) {
      shown_movies = [];
      //print(value);
      for (int i = 0; i < movies.length; i++) {
        if (movies[i].movie_name.toLowerCase().contains(value.toLowerCase())) {
          shown_movies.add(movies[i]);
        }
      }
    }
    //if (!mounted) return;
    setState(() {});
  }

  Widget _buildUserIcon() {
    if (MyApp.user.userImage == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          "https://www.kindpng.com/picc/m/193-1930135_flat-user-icon-hd-png-download.png",
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          MyApp.user.userImage as String,
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
      );
    }
    //setState(() => {});
  }

  Widget _buildChild() {
    if (shown_movies.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            childAspectRatio: (1 / 2),
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                                movie: shown_movies[index],
                              )))
                    },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        shown_movies[index].image_url,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        shown_movies[index].movie_name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ));
          },
          itemCount: shown_movies.length,
        ),
      );
    }
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Oh darn. We don't have that.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "Try searching for another movie.",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //_getMovieList();
    //shown_movies = movies;
    return Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 30, 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CurrentPage()));
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.grey, shape: const CircleBorder()),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  _buildUserIcon()
                ],
              ),
            ),
            TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  //icon: Icon(Icons.search),
                  hintText: "Search for a movie",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (String value) async {
                  _returnSearchedMovies(value);
                }
                ),
            _buildChild()
          ],
        )
    );
  }
}
