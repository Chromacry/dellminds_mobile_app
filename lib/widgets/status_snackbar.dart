import 'package:flutter/material.dart';

class StatusSnackbar {
  static SnackBar snackbarStatus({required String textMessage}) => SnackBar(
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11))),
      content: Text(
        textMessage,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey[800],
      elevation: 5,
    );
}
