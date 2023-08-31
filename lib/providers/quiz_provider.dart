import 'package:flutter/material.dart';
import 'dart:core';

class QuizProvider extends ChangeNotifier {
   List<QuizQuestion> unusedQuestions = [];

  QuizProvider() {
    unusedQuestions = List.from(quizQuestions)..shuffle();
  }
  
  Map<String, int> activityScores = {
    'Sports': 0,
    'Arts': 0,
    'Cooking': 0,
    'Outdoors': 0,
  };
    
  //* Updates scores
  void updateScore(String category) {
    if (category != null) {
      activityScores[category] = (activityScores[category] ?? 0) + 1;
      notifyListeners(); 
    }
  }

  String getCategoryFromChosenOption(String chosenOption) {
  if (['Football', 'Volleyball', 'Basketball'].contains(chosenOption)) {
    return 'Sports';
  } else if (['Music', 'Painting', 'Photography'].contains(chosenOption)) {
    return 'Arts';
  } else if (chosenOption == 'Nature Walks') {
    return 'Outdoors';
  } else {
    return 'Other';
  }
}

String getCategoryWithHighestScore() {
    String maxCategory = '';
    int maxScore = -1;

    activityScores.forEach((category, score) {
      if (score > maxScore) {
        maxScore = score;
        maxCategory = category;
      }
    });

    return maxCategory;
  }

IconData getIconFromChosenOption(String chosenOption) {
  switch (chosenOption) {
    case 'Football':
      return Icons.sports_soccer;
    case 'Volleyball':
      return Icons.sports_volleyball;
    case 'Basketball':
      return Icons.sports_basketball;
    case 'Music':
      return Icons.music_note;
    case 'Painting':
      return Icons.brush;
    case 'Photography':
      return Icons.camera_alt;
    case 'Nature Walks':
      return Icons.nature_people;
    default:
      return Icons.star; // Default icon if activity type is not recognized
  }
}




}

class QuizQuestion {
  final String option1;
  final String option2;

  QuizQuestion(this.option1, this.option2);

}

List<QuizQuestion> quizQuestions = [
  QuizQuestion('Football', 'Music'),
  QuizQuestion('Painting', 'Basketball'),
  QuizQuestion('Photography', 'Volleyball'),

  // more questions
];
