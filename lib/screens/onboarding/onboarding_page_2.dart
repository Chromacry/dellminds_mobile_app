import 'package:dellminds_mobile_app/screens/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_4.dart';

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
                'But first...',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 20),
              Text(
                'Let\'s do a quick sign up! Press the button below to get started.',
                style: OnboardingStyles.subheaderText,
              ),
              SizedBox(height: 40),
              // Next button
              Container(
                width: OnboardingStyles.nextButtonWidth,
                height: OnboardingStyles.nextButtonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      SignUpScreen.routeName,
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
                        'Sign Up',
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
