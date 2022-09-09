import 'package:flutter/material.dart';
import 'package:moveo_app/main.dart';
import '../dialog/category_dialog.dart';
import '../route.dart';
class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final double scrollOffset;

  const CustomAppBar({Key? key, this.scrollOffset = 0.0,}) : super(key: key);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
class _CustomAppBarState extends State<CustomAppBar>{
  Widget _buildUserIcon() {
    if (MyApp.user.userImage == null){
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          "https://www.kindpng.com/picc/m/193-1930135_flat-user-icon-hd-png-download.png",
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
      );
    }
    else {
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

  Size get preferredSize => const Size.fromHeight(150);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        color: Colors.black
            .withOpacity((widget.scrollOffset / 350).clamp(0, 1).toDouble()),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/netflix_logo.png',
                  height: 70,
                ),
                const Spacer(),
                IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).push(SearchRoute());
                  },
                  icon: const Icon(Icons.search),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: _buildUserIcon(),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'TV Shows',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Movies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const CategoryDialog());
                      },
                      child: const Text(
                        'Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ],
            )
          ],
        ));
  }
}
