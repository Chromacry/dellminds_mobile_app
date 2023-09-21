import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:flutter/material.dart';

class OnboardingStyles{
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
    color: Colors.white,
  );
  //* Submit Button
  static const Size buttonSize = Size(350, 50);
  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.black,
  );
  static const Color iconColor = Colors.black;

  //* Header and Subheader Text
  static const headerText = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: DesignConstants.COLOR_THEMEPINK,
  );

  static const subheaderText = TextStyle(
    fontSize: 18,
    color: Colors.grey,
  );

   //* Next Button with Circular Arrow
  static const nextButtonColor = DesignConstants.COLOR_THEMEPINK;
  static const nextButtonTextColor = Colors.white;
  static const nextButtonHeight = 60.0;
  static const nextButtonWidth = 160.0;
  static const nextButtonArrowColor = Colors.white;
  static const nextButtonArrowSize = 30.0;

  //* Quiz Button
  static const quizButtonTextColor = Colors.white;
  static const quizButtonHeight = 200.0;
  static const quizButtonWidth = double.infinity;
  
}

class ButtonStyles {
  static final commonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    minimumSize: Size(OnboardingStyles.quizButtonWidth, OnboardingStyles.quizButtonHeight),
  );

  static final sportsStyle = commonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(Colors.blue),
  );

  static final artsStyle = commonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(Colors.orange),
  );

  static final cookingStyle = commonStyle.copyWith(
    backgroundColor: MaterialStateProperty.all(Colors.green),
  );

  static MaterialStateProperty<Color?> getStyleFromCategory(String category) {
    switch (category) {
      case 'Sports':
        return MaterialStateProperty.all(Colors.blue);
      case 'Arts':
        return MaterialStateProperty.all(Colors.orange);
      case 'Cooking':
        return MaterialStateProperty.all(Colors.green);
      default:
        return MaterialStateProperty.all(Colors.grey); // Default style
    }
  }
}


