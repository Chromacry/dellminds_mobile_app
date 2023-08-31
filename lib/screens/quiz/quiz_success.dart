import 'package:dellminds_mobile_app/main.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/providers/quiz_provider.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class QuizSuccessPage extends StatefulWidget {
  @override
  State<QuizSuccessPage> createState() => _QuizSuccessPageState();
}

class _QuizSuccessPageState extends State<QuizSuccessPage> {
  late QuizProvider quizProvider;
  late UserDummyProvider userDummyProvider;

  @override
  void initState() {
    super.initState();
    quizProvider = Provider.of<QuizProvider>(context,
        listen: false); // Initialize quizProvider
    userDummyProvider = Provider.of<UserDummyProvider>(context, listen: false);

    final randomUserId = generateRandomUserId();
    final recommendedCategory = quizProvider.getCategoryWithHighestScore();

    userDummyProvider.setUserInfo(randomUserId, recommendedCategory);

    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String highestCategory = quizProvider.getCategoryWithHighestScore();
    String message =
        'Good Job! It seems you are more interested in $highestCategory!';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: OnboardingStyles.headerText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Press the button below to get started!',
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
                    MaterialPageRoute(builder: (context) => MainScreen()),
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
                      'Let\'s Go!',
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

String generateRandomUserId() {
  final uuid = Uuid();
  return uuid.v4();
}
