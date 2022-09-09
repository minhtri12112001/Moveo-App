import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/global_security_storage.dart';
import 'package:moveo_app/main.dart';
import 'package:moveo_app/page/management_page.dart';
import 'package:moveo_app/page/my_list_page.dart';
import 'package:moveo_app/page/manage_profiles_page.dart';
import 'package:flutter_switch/flutter_switch.dart';
class SettingPage extends StatefulWidget{
  const SettingPage({Key? key}) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPageState();


}
class _SettingPageState extends State<SettingPage> {
  bool status = false;
  Widget _buildUserIcon() {
    if (MyApp.user.userImage == null){
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          "https://www.kindpng.com/picc/m/193-1930135_flat-user-icon-hd-png-download.png",
          fit: BoxFit.cover,
        ),
      );
    }
    else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          MyApp.user.userImage as String,
          fit: BoxFit.cover,
        ),
      );
    }
    //setState(() => {});
  }
  Widget _buildRoleSwitch(){
    if (MyApp.user.userRole == "admin"){
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Text(
                "User Mode",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            FlutterSwitch(
                value: status,
                onToggle: (val) {
                  //status = val;
                  setState((){});
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ManagementPage()));
                }),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Admin Mode",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              height: 150,
              width: 150,
              margin: const EdgeInsets.only(top: 50),
              child: _buildUserIcon(),
            ),
            _buildRoleSwitch(),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageProfilesPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Manage Profiles",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyListPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.list,
                      size: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "My list",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings_outlined,
                      size: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "App Settings",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      size: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Help",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    GlobalSecurityStorage.deleteAllStorageData();
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: const Text("Sign out")
              ),
            )
          ],
        )
      ],
    );
  }
}