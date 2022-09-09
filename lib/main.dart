import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/global_security_storage.dart';
import 'package:moveo_app/page/sign_in_page.dart';
import 'model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'current_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  //static final user = UserModel.fromJson(GlobalSecurityStorage.getUser())
  ///*
  //static final user = UserModel.fromJson(await )
  static var user = UserModel(null, null, null, null, null, null);
   //*/
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> with  WidgetsBindingObserver{
  void checkCurrentUser() {
    /*
    if (FirebaseAuth.instance.currentUser?.uid != null && MyApp.user.userId == null){
      FirebaseAuth.instance.signOut();
      //setState(() => {});

    }

    */
    if (MyApp.user.userId == null){
      FirebaseAuth.instance.signOut();
    }
  }
  void printUser() async {
    //print(await GlobalSecurityStorage.getUser());
    //print(DateTime.now().toString());
  }
  void getStorageUser() async {
    if (MyApp.user.userId == null){
      MyApp.user = UserModel.fromJson(await GlobalSecurityStorage.getUser());
      //print(MyApp.user.userEmail);
    }
    //checkCurrentUser();
    print(MyApp.user.userId);
    setState(() => {});
  }
  Widget _buildChild() {
    if(FirebaseAuth.instance.currentUser?.uid != null){
      getStorageUser();
      return const CurrentPage();
    }
    else {
      return const SignInPage();
    }
  }
   //*/
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    //state ==  AppLifecycleState.paused;
    if (state == AppLifecycleState.detached && UserModel.fromJson(await GlobalSecurityStorage.getUser()).userId == null) {
      FirebaseAuth.instance.signOut();
    }
  }
  @override
  Widget build(BuildContext context) {
    //print(GlobalSecurityStorage.getUser())
    return MaterialApp(
      title: 'Flutter Demo',
      /*
      theme: ThemeData(
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.black,
        //scaffoldBackgroundColor: Colors.black
      ),
       */

      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      //home: SignInPage(),
      home: _buildChild()
    );
  }
}

