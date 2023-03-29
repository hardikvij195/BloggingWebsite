import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internship_website/feature/blogs/screens/home_screen.dart';
import 'package:internship_website/feature/blogs/store/main_store.dart';
import 'package:provider/provider.dart';
import 'feature/login/login.dart';
import 'feature/login/store/login_store.dart';
import 'firebase_options.dart';

import 'feature/blogs/store/blogs_store.dart';

//late int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStore>(
          create: (_) => LoginStore(),
        ),
        Provider(create: (_) => MainStore()..initInternetStream()),
        Provider(create: (_) => BlogsStore()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const CheckLogin(),
      ),
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  CheckLoginState createState() => CheckLoginState();
}

class CheckLoginState extends State<CheckLogin> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated(context)
        .then((value) {
      if (value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Checking Login")
        ],
      ),
    );
  }
}
