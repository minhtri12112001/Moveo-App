import 'package:flutter/material.dart';
import 'package:moveo_app/form/sign_in_form.dart';
import 'package:moveo_app/page/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              "Sign In",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SignInForm(),
          Container(
            padding: const EdgeInsets.all(50),
            child: Row(
              children: [
                const Text(
                  "New to Moveo?",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Text(
                      "Sign up now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
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