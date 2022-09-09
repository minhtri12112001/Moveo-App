import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:moveo_app/current_page.dart';
import 'package:moveo_app/form/add_movie_form.dart';
import 'package:moveo_app/form/update_movie_form.dart';
import '../model/movie_model.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);
  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  List<MovieModel> movies = [];
  void _getMovieList() {
    List<MovieModel> firebase_movies = [];
    FirebaseFirestore.instance.collection("movies").get().then((querySnapshot) {
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
        //print(data);
        firebase_movies.add(movie);
        movies = firebase_movies;
        setState(() => {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _getMovieList();
    return Scaffold(
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Movie List",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: AddMovieForm(),
                          )
                      );
                    },
                    child: Text("Add new")),
                Spacer(),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 55, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlutterSwitch(
                        value: true,
                        onToggle: (val) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CurrentPage()));
                        },
                      ),
                      Text("Admin Mode")
                    ],
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                return Container(
                  //width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movies[index].image_url,
                          height: 80,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: 220,
                        child: Column(
                          children: [
                            Text(
                              "id: " + movies[index].id,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                            //Text("movie_name: " + movies[index].movie_name),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                        child: UpdateMovieForm(movie: movies[index])
                                    )
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Delete Request"),
                                        content: Text("Are you sure that this item will be deleted?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                            onPressed: () {
                                              FirebaseFirestore.instance.collection('movies')
                                                  .doc(movies[index].id)
                                                  .delete()
                                                  .then((value) => print(movies[index].movie_name + " Are Deleted"))
                                                  .catchError((error) => print("Failed to delete user: $error"));
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                )
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
