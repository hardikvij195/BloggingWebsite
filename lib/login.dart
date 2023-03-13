import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship_website/blogs/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  String email = "", password = "";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: height,
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.4,
        ),
        //color: AppColors.backColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.2),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Let’s',
                        style: TextStyle(
                          fontSize: 28.0,
                          //color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.normal,
                        )),
                    TextSpan(
                      text: ' Sign In 👇',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //color: AppColors.blueDarkColor,
                        fontSize: 28.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.07),
              emailField(size),
              SizedBox(height: height * 0.03),
              passwordField(size),
              SizedBox(height: height * 0.05),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _login(email, password);
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70.0, vertical: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.blue.shade700),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        //color: AppColors.whiteColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column passwordField(var size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Password',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 50.0,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey)
              //color: AppColors.whiteColor,
              ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                password = value.trim();
              });
            },
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              //color: AppColors.blueDarkColor,
              fontSize: 12.0,
            ),
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.only(top: 16.0),
              hintText: 'Enter Password',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                //color: AppColors.blueDarkColor.withOpacity(0.5),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column emailField(var size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Email',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 50.0,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey)
              //color: AppColors.whiteColor,
              ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                email = value.trim();
              });
            },
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              //color: AppColors.blueDarkColor,
              fontSize: 12.0,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.only(top: 16.0),
              hintText: 'Enter Email',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                //color: AppColors.blueDarkColor.withOpacity(0.5),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _login(String _email, String _password) async {
    User? updateUser = FirebaseAuth.instance.currentUser;
    late User user;

    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    bool verified = false;
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      firestoreInstance
          .collection("DateUsers")
          .doc(firebaseUser!.uid)
          .get()
          .then((value) async {
        verified = value.data()!["isVerified"];

        if (verified == true) {
          const ScaffoldMessenger(child: Text("Login successful."));
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('remember', true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (verified == false) {
          const ScaffoldMessenger(child: Text("You are not verified."));
        }
      });
    } on FirebaseAuthException catch (error) {
      print(error.message);
      ScaffoldMessenger(
        child: Text("${error.message}"),
      );
    }
  }
}
