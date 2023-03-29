import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internship_website/core/helper/name_helper.dart';
import 'package:internship_website/feature/login/store/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  final loginStore = LoginStore();
  TextEditingController pass = TextEditingController();

  bool _showPassword = true;

  Widget button(String txt, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Observer(
        builder: (_) {
          if (loginStore.isLoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GestureDetector(
              onTap: () async {
                if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                  await loginStore.signInWithEmailPass(
                    context,
                    email.text.trim(),
                    pass.text.trim(),
                  );
                } else {
                  await tost('Pls fill all the details');
                }
              },
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 13,
                width: double.maxFinite,
                child: Center(
                  child: SelectableText(
                    txt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget googleSignInBtn(BuildContext context) {
    return Observer(
      builder: (_) {
        if (loginStore.isGoogleSignInLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GestureDetector(
              onTap: () async {
                await loginStore.google(context);
              },
              child: Image.asset(
                "assets/png/google-logo.png",
                height: 50,
                width: 50,
              ));
        }
      },
    );
  }

  Widget passwordField(TextEditingController textEditingController) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: textEditingController,
            style: const TextStyle(
              fontSize: 15,
            ),
            obscureText: _showPassword,
            decoration: InputDecoration(
              labelText: "Password",
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField(String hint, TextEditingController textEditingController) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: textEditingController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: hint,
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/png/mw512.png",
                  height: 200,
                ),
                const SizedBox(height: 30),
                emailField("Email", email),
                const SizedBox(height: 20),
                passwordField(pass),
                const SizedBox(height: 30),
                button("Login", context),
                const SizedBox(height: 30),
                const Text("Or sign in Through"),
                const SizedBox(height: 10),
                googleSignInBtn(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
