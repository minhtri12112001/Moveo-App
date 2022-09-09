import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/main.dart';
import 'package:moveo_app/model/user_model.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final userAddressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Username",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please do not let your username empty.';
                  }
                  return null;
                },
                controller: userNameController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Address",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please do not let your address empty.';
                  }
                  return null;
                },
                controller: userAddressController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email address",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please do not let your email empty.';
                  }
                  return null;
                },
                controller: emailController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please do not let your password empty.';
                  }
                  return null;
                },
                controller: passwordController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Confirm password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm above password.';
                  }
                  return null;
                },
                controller: confirmPasswordController,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserModel user;
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        )
                        .then((value) {
                          user = UserModel(value.user!.uid, emailController.text, null, userNameController.text, userAddressController.text, "client");
                          FirebaseFirestore.instance.collection("users")
                              .doc(user.userId).set(
                              {
                                "user_email": user.userEmail,
                                "user_name": user.userName,
                                "user_address": user.userAddress,
                                "user_role": "client",
                              }
                          );
                          MyApp.user = user;
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const MyApp()));
                        }
                        );
                      }
                      on FirebaseAuthException catch (e) {
                        print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18  ,
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}