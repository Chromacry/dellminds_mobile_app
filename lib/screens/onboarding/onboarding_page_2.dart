import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_3.dart';

class OnboardingPage2 extends StatelessWidget {
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
                'How does it work?',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 20),
              Text(
                'First, we have to found out what activities you like through a simple quiz!',
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
                          builder: (context) => OnboardingPage3()),
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
