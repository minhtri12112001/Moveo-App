import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/main.dart';

import '../current_page.dart';
class ManageProfilesPage extends StatefulWidget{
  const ManageProfilesPage({Key? key}) : super(key: key);
  @override
  State<ManageProfilesPage> createState() => _ManageProfilesPageState();


}
class _ManageProfilesPageState extends State<ManageProfilesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  void _getUserProfile() {
    userNameController.text = MyApp.user.userName as String;
    emailController.text = MyApp.user.userEmail as String;
    addressController.text = MyApp.user.userAddress as String;
  }
  @override
  Widget build(BuildContext context) {
    _getUserProfile();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: userNameController,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Address",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: addressController,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseFirestore.instance.collection('users')
                                .doc(MyApp.user.userId)
                                .update(
                                {
                                  "user_name": userNameController.text,
                                  "user_email": emailController.text,
                                  "user_address": addressController.text,
                                }
                            )
                                .then((value) => print("User Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                            Navigator.pop(context, "Update");
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: const Text(
                            'Update profiles',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}