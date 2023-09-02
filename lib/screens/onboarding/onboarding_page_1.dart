import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_2.dart';

class OnboardingPage1 extends StatelessWidget {
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
                'What else does BookBud do?',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 20),
              Text(
                'BookBud allows you to find your friends and join events with them!',
                style: OnboardingStyles.subheaderText,
              ),
              SizedBox(height: 40),

              // Next button
              Container(
                width: OnboardingStyles.nextButtonWidth,
                height: OnboardingStyles.nextButtonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingPage2()),
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
      ),
    );
  }
}
