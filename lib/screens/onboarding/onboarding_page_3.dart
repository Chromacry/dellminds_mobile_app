import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_4.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';

class OnboardingPage3 extends StatelessWidget {
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
                'Quiz Example',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 40),

              //* Quiz example option 1 
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage4()),
                  );
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
                  backgroundColor: ButtonStyles.sportsStyle
                      .backgroundColor, // Maintain the primary color
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.sports_soccer,
                      size: 50, 
                      color: OnboardingStyles.nextButtonArrowColor,
                    ),
                    SizedBox(height: 10), 
                    Text(
                      'Football',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              //* Quiz example option 1           
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage4()),
                  );
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
                child: Column(
                  children: [
                    Icon(
                      Icons.brush,
                      size: 50, // Adjust the icon size
                      color: OnboardingStyles.nextButtonArrowColor,
                    ),
                    SizedBox(height: 10), // Add some vertical spacing
                    Text(
                      'Painting',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
