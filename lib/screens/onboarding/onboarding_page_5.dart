import 'package:dellminds_mobile_app/screens/quiz/quiz_page_1.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';

class OnboardingPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Good Pick! Ready to begin?',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 40),
              Container(
                width: OnboardingStyles.nextButtonWidth,
                height: OnboardingStyles.nextButtonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => QuizPage1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OnboardingStyles.nextButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          OnboardingStyles.nextButtonWidth /
                              6), // Adjust the radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: OnboardingStyles.nextButtonArrowColor,
                        size: OnboardingStyles.nextButtonArrowSize,
                      ),
                      Text(
                        'Start Quiz',
                        style: TextStyle(
                          color: OnboardingStyles.nextButtonTextColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
