
import 'package:dellminds_mobile_app/providers/quiz_provider.dart';
import 'package:dellminds_mobile_app/screens/quiz/quiz_page_3.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_style.dart';
import 'package:provider/provider.dart';

class QuizPage2 extends StatefulWidget {
  @override
  State<QuizPage2> createState() => _QuizPage2State();
}

class _QuizPage2State extends State<QuizPage2> {
  late QuizProvider quizProvider;

  late QuizQuestion currentQuestion;

 @override
  void initState() {
    super.initState();
    quizProvider = Provider.of<QuizProvider>(context,
        listen: false); // Initialize quizProvider

    currentQuestion = quizProvider.unusedQuestions.first;
  }

  void handleAnswer(String chosenOption) {
    // Process the answer and get the next question
    quizProvider
        .updateScore(quizProvider.getCategoryFromChosenOption(chosenOption));
    debugPrint('Printing Score:');
    quizProvider.activityScores.forEach((key, value) {
      debugPrint('$key: $value');
    });
    quizProvider.unusedQuestions.removeAt(0); // Remove the current question

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage3()),
    );
  }

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
                'Question 2',
                style: OnboardingStyles.headerText,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Handle button press for Option 1
                  handleAnswer(currentQuestion.option1);
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
                  backgroundColor: ButtonStyles.getStyleFromCategory(
                    quizProvider
                        .getCategoryFromChosenOption(currentQuestion.option1),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      quizProvider
                          .getIconFromChosenOption(currentQuestion.option1),
                      size: 50, // Adjust the icon size
                      color: OnboardingStyles.nextButtonArrowColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentQuestion.option1, // Display option 1
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press for Option 2
                  handleAnswer(currentQuestion.option2);
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
                  backgroundColor: ButtonStyles.getStyleFromCategory(
                    quizProvider
                        .getCategoryFromChosenOption(currentQuestion.option2),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      quizProvider
                          .getIconFromChosenOption(currentQuestion.option2),
                      size: 50, // Adjust the icon size
                      color: OnboardingStyles.nextButtonArrowColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentQuestion.option2, // Display option 2
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
