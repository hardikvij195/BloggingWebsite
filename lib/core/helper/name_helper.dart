import 'package:fluttertoast/fluttertoast.dart';

Future<void> tost(String message, {ToastGravity? gravity}) {
  return Fluttertoast.showToast(
    toastLength: Toast.LENGTH_LONG,
    msg: message,
    gravity: gravity,
  );
}
