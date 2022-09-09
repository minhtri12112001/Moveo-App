import 'package:flutter/material.dart';
import 'package:moveo_app/page/sign_in_page.dart';
import 'package:moveo_app/form/sign_up_form.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(50),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SignUpForm(),
          Container(
            padding: const EdgeInsets.all(50),
            child: Row(
              children: [
                const Text(
                  "Already have Moveo account?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignInPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Text(
                      "Sign in now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}