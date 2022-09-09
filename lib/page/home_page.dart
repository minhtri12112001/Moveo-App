import 'package:flutter/material.dart';
import '../home_page_components/movie_banner.dart';
import '../home_page_components/genres_list.dart';
import '../home_page_components/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    //print(MyApp.user.userId);
    return GestureDetector(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            Container(
              child: MovieBanner(),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sinhala Sangam MN',
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const GenresList(genre: "Action"),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Animation',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sinhala Sangam MN',
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const GenresList(genre: "Animation"),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Anime',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sinhala Sangam MN',
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const GenresList(genre: "Anime"),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Romance',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sinhala Sangam MN',
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const GenresList(genre: "Romance"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
