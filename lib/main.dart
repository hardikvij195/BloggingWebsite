import 'package:flutter/material.dart';
import 'package:internship_website/WriteBlog.dart';
import 'package:internship_website/createBlogProfile.dart';
import 'package:internship_website/homePage.dart';
import 'package:internship_website/login.dart';
import 'package:internship_website/profile.dart';
import 'package:internship_website/readBlog.dart';
import 'package:internship_website/temp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internship_website/trash.dart';
import 'package:shared_preferences/shared_preferences.dart';

//late int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAI6hWWy5quQTVgAhtUXrSK44y5ZOSG8D4",
          authDomain: "mw-analysis.firebaseapp.com",
          projectId: "mw-analysis",
          storageBucket: "mw-analysis.appspot.com",
          messagingSenderId: "1066554580954",
          appId: "1:1066554580954:web:12c3c42b91cfad4265aae3",
          measurementId: "G-7BPN29EY31"
      )
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}