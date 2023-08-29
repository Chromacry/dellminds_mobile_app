import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_1.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to BookBud?',
              style: OnboardingStyles.headerText,
            ),
            SizedBox(height: 20),
            Text(
              'BookBud helps you discover fun activities that you\'ll enjoy!',
              style: OnboardingStyles.subheaderText,
            ),
            SizedBox(height: 40),
            Container(
              width: OnboardingStyles.nextButtonWidth,
              height: OnboardingStyles.nextButtonHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage1()),
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
                      'Next',
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
    );
  }
}


