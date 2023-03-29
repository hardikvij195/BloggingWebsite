import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internship_website/core/helper/name_helper.dart';
import 'package:internship_website/feature/blogs/screens/home_screen.dart';
import 'package:mobx/mobx.dart';
import '../login.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase extends ChangeNotifier with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  bool isLoginLoading = false;

  @observable
  bool isGoogleSignInLoading = false;

  User? firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated(BuildContext context) async {
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final DocumentSnapshot dc = await FirebaseFirestore.instance
          .collection("ProUsers")
          .doc(firebaseUser!.uid)
          .get();

      if (dc.exists) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> onAuthenticationSuccessful(
    BuildContext context,
    User user,
  ) async {
    firebaseUser = user;
    final DocumentSnapshot dc = await FirebaseFirestore.instance
        .collection("ProUsers")
        .doc(user.uid)
        .get();

    if (dc.exists) {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
      isLoginLoading = false;
    } else {
      await _auth.signOut();
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
      isLoginLoading = false;
    }
  }

  @action
  Future<void> signInWithEmailPass(
    BuildContext context,
    String email,
    String pass,
  ) async {
    try {
      isLoginLoading = true;
      await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: pass.trim(),
      )
          .then((authResult) {
        if (authResult.user != null) {
          onAuthenticationSuccessful(context, authResult.user!);
        } else {
          tost("Something Went Wrong");
          isLoginLoading = false;
        }
      });
    } on Exception catch (error) {
      isLoginLoading = false;
      switch (error.toString()) {
        case "email-already-in-use":
          // ignore: avoid_print
          await tost("User with this email already regsiterd.");
          break;
        case "wrong-password":
          // ignore: avoid_print
          await tost("Your password is wrong.");
          break;
        case "user-not-found":
          // ignore: avoid_print
          await tost("User with this email doesn't exist.");
          break;
        case "user-disabled":
          // ignore: avoid_print
          await tost("User with this email has been disabled.");
          break;
        case "too-many-requests":
          await tost("Too many requests. Try again later.");
          break;
        case "operation-not-allowed":
          await tost("Signing in with Email and Password is not enabled.");
          break;
        default:
          await tost('Pls Check your details');
      }
    }
  }

  @action
  Future<void> google(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    isGoogleSignInLoading = true;
    await googleSignIn.signOut();
    await _auth.signOut();
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
        if (userCredential.user != null) {
          // ignore: use_build_context_synchronously
          onAuthenticationSuccessful(context, userCredential.user!);
        } else {
          isGoogleSignInLoading = false;
          await tost("Something Went Wrong");
        }
      } else {
        isGoogleSignInLoading = false;
      }
    } on Exception catch (e) {
      isGoogleSignInLoading = false;
      await tost(e.toString());
    }
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
