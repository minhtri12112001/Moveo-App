import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/global_security_storage.dart';
import 'package:moveo_app/main.dart';
import 'package:moveo_app/model/user_model.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;
  /*
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

   */

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
                    hintText: "Email or phone number",
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
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: passwordController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Checkbox(
                      focusColor: Colors.white,
                      activeColor: Colors.grey,
                      value: isChecked,
                      onChanged: (bool? value) {
                        isChecked = value!;
                        setState(() => {});
                      }),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Remember me"),
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      UserModel user;
                      try {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) => {
                                  if (isChecked == true) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(value.user!.uid)
                                        .get()
                                        .then((value) async => {
                                      user = UserModel(
                                          value.id,
                                          emailController.text,
                                          value["user_image"],
                                          value["user_name"],
                                          value["user_address"],
                                          value["user_role"]
                                      ),
                                      await GlobalSecurityStorage.setUser(user),
                                      //print(value.id),
                                      //print(value["user_name"]),
                                    })
                                  }
                                  else {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(value.user!.uid)
                                        .get()
                                        .then((value) => {
                                      user = UserModel(
                                          value.id,
                                          emailController.text,
                                          value["user_image"],
                                          value["user_name"],
                                          value["user_address"],
                                          value["user_role"]
                                      ),
                                      MyApp.user = user,
                                      //print(user.userId),
                                      //print(FirebaseAuth.instance.currentUser?.uid)
                                    })
                                  },
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const MyApp()))
                                });
                      } on FirebaseAuthException catch (e) {
                        //print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
