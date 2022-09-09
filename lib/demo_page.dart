/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/model/movie_model.dart';
import 'dart:developer';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);
  @override
  State<DemoPage> createState() => _DemoPageState();

}

class _DemoPageState extends State<DemoPage>{
  String movie = "Not exsists";
  String status = "Invisible";
  Future<void> getDemoMovie() async {
    FirebaseFirestore.instance.collection("movies")
        .doc("49liu0ENVEjNXnxs6znU")
        .get()
        .then((value) => status = "Visible");
    //return "Is exists";
  }
  /*
  void printState() async {
    movie = await getDemoMovie();
    //log('demo: $view');
    print(movie);
  }

   */
  Widget buildDemo () async {
    if (status == "Invisible") {
      return Text(status);
    }
    return Text(status);
  }
  @override
  Widget build(BuildContext context) {
    //printState();
    print(movie);
    //log('demo: $view');
    return Container(
      child: buildDemo(),
    );
  }
}

 */