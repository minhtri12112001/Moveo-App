import 'package:flutter/material.dart';
import '../page/movie_list_page.dart';
class CategoryDialog extends StatefulWidget {
  const CategoryDialog({Key? key}) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}
class _CategoryDialogState extends State<CategoryDialog>{
  int currentIndex = 0;
  List genres = ['Action', 'Anime', 'Animation', 'Adventure','Comedy', 'Documentary', 'Drama', 'Horror', 'K-Drama', 'Romance', 'Sci-Fi'];
  void _selectGenresToNavigate(int index){
    currentIndex = index;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MovieListPage(search_key: genres[currentIndex])));
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          children: [
            ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        _selectGenresToNavigate(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          genres[index],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Center(
                //left: 105,
                //bottom: 50,
                  child: ElevatedButton(
                    //onPrimary: Colors.amber,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    style: ElevatedButton.styleFrom(

                        primary: Colors.white,
                        padding: const EdgeInsets.all(20),
                        shape: const CircleBorder()
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
              ),
            )
          ],
        )
      ),
    );
  }
}
