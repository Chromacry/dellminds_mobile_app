import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_2.dart';

class TutorialStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header and subheader
              Text(
                'Before we proceed, let\'s go through a tutorial.',
                style: OnboardingStyles.headerText,
                textAlign: TextAlign.center, // Center align the text
              ),
              SizedBox(height: 20),
              Text(
                'This tutorial will help you to better understand the app.',
                style: OnboardingStyles.subheaderText,
                textAlign: TextAlign.center, // Center align the text
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Button for the next page of the tutorial
                  Container(
                    width: OnboardingStyles.nextButtonWidth,
                    height: OnboardingStyles.nextButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TutorialPage()),
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

                  // Button to navigate to HomeScreen
                  Container(
                    width: OnboardingStyles.nextButtonWidth,
                    height: OnboardingStyles.nextButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                          (route) => false, // Remove all previous routes
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
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
                            Icons.home,
                            color: OnboardingStyles.nextButtonArrowColor,
                            size: OnboardingStyles.nextButtonArrowSize,
                          ),
                          Text(
                            'Skip',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
