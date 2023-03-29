import 'package:firebase_auth/firebase_auth.dart';

String getUserUid() {
  return FirebaseAuth.instance.currentUser!.uid;
}
