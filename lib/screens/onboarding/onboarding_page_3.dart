import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';

class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Example',
              style: OnboardingStyles.headerText,
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle button press for Football
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: OnboardingStyles.quizButtonTextColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(
                  OnboardingStyles.quizButtonWidth,
                  OnboardingStyles.quizButtonHeight,
                ),
              ).copyWith(
                backgroundColor: ButtonStyles
                    .sportsStyle.backgroundColor, // Maintain the primary color
              ),
              child: Text(
                'Football',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20), // Add some vertical spacing
            ElevatedButton(
              onPressed: () {
                // Handle button press for Painting
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: OnboardingStyles.quizButtonTextColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(
                  OnboardingStyles.quizButtonWidth,
                  OnboardingStyles.quizButtonHeight,
                ),
              ).copyWith(
                backgroundColor: ButtonStyles
                    .artsStyle.backgroundColor, // Maintain the primary color
              ),
              child: Text(
                'Painting',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: OnboardingStyles.nextButtonWidth,
              height: OnboardingStyles.nextButtonHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage3()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: OnboardingStyles.nextButtonColor,
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
