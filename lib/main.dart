import 'package:flutter/material.dart';
import 'package:internship_website/blogs/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internship_website/blogs/store/blogs_store.dart';
import 'package:provider/provider.dart';

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
          measurementId: "G-7BPN29EY31"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => BlogsStore()..init()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
