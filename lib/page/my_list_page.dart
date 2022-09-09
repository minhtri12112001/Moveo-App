import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/page/movie_detail_page.dart';
import '../../model/movie_model.dart';
import '../main.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);
  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<MovieModel> movies = [];
  @override initState(){
    super.initState();
    getMyList();
    setState(() => {});
  }
  void getMyList() {
    List<MovieModel> firebase_movies = [];
    FirebaseFirestore.instance.collection("/users/" + MyApp.user.userId.toString() + "/myList").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
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
        firebase_movies.add(movie);
        movies = firebase_movies;
        //if (!mounted) return;
        setState(() => {});
      });
    });
  }
  Widget _buildChild() {
    //getMyList();
    if (movies.length > 0) {
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
                        movie: movies[index],
                      )))
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        movies[index].image_url,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        movies[index].movie_name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ));
          },
          itemCount: movies.length,
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
                  "Oh darn. Looks like you haven't added any movies yet.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Try to add any movies you want to watch again.",
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          _buildChild(),
        ],
      ),
    );
  }
}