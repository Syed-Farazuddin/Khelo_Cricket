import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  // Toaster
  static void onSuccess({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      fontSize: 20,
      toastLength: Toast.LENGTH_SHORT,
      webPosition: "top",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
    );
  }

  static void cancelToasts() {
    Fluttertoast.cancel();
  }

  static void onError({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      webPosition: "top",
      gravity: ToastGravity.CENTER,
      fontSize: 20,
      backgroundColor: Colors.red,
    );
  }
}
