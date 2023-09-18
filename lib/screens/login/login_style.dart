import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:flutter/material.dart';

class LoginStyles {
  //* Logo
  static const EdgeInsets logoMargin = EdgeInsets.only(bottom: 10);
  static const double logoWidth = 200;
  static const double logoHeight = 150;

  //* Login Text
  static const Alignment titleAlign = Alignment.centerLeft;
  static const EdgeInsets titleContainerMargin = EdgeInsets.only(bottom: 10);
  static const title = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 75, 10, 32),
  );
  //* Submit Button
  static const Size buttonSize = Size(350, 50);
  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.white,
  );
  static const Color iconColor = Colors.black;
  static const Color buttonColor = DesignConstants.COLOR_THEMEPINK;


}
