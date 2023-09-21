import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:provider/provider.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizQuestion> unusedQuestions = [];
  String topCategory1 = 'None'; 
  String topCategory2 = 'None'; 

  QuizProvider() {
    if (quizQuestions.isNotEmpty) {
      unusedQuestions = List.from(quizQuestions)..shuffle();
    }
  }

  Map<String, int> activityScores = {
    'Sports': 0,
    'Arts': 0,
    'Cooking': 0,
    'Outdoors': 0,
  };

  //* Updates scores
  void updateScore(String category) {
    activityScores[category] = (activityScores[category] ?? 0) + 1;
    notifyListeners();
  }

  void resetQuiz() {
    if (quizQuestions.isNotEmpty) {
      unusedQuestions = List.from(quizQuestions)..shuffle();
    }
    topCategory1 = 'None';
    topCategory2 = 'None';
    activityScores = {
      'Football': 0,
      'Basketball': 0,
      'Painting': 0,
      'Music': 0,
    };
    notifyListeners();
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

  List<String> findTopCategories(List<CategoryScore> scores) {
    // Sort the list of CategoryScore objects by score in descending order
    scores.sort((a, b) => b.score.compareTo(a.score));

    // Ensure there are at least two categories in the list
    if (scores.length >= 2) {
      final topCategory = scores[0];
      final secondCategory = scores[1];

      // Calculate the threshold for a significant difference
      final threshold = (topCategory.score - secondCategory.score) / 2;

      if (secondCategory.score >= threshold) {
        return [topCategory.category, secondCategory.category];
      }
    }

    // If the difference is too large, consider the second category as "non"
    return [scores[0].category, 'None'];
  }

  Future<void> calculateAndStoreTopCategories(BuildContext context) async {
    print('Calculating..');

    final categoryScoresList = activityScores.entries
        .map((entry) => CategoryScore(entry.key, entry.value.toDouble()))
        .toList();

    final topCategories = findTopCategories(categoryScoresList);

    final category1 = topCategories.isNotEmpty ? topCategories[0] : 'None';
    final category2 = topCategories.length > 1 ? topCategories[1] : 'None';

    print('CAT 1: $category1');
    print('CAT 2: $category2');

    final userDummyProvider =
        Provider.of<UserDummyProvider>(context, listen: false);

    await Future.delayed(Duration(milliseconds: 0));

    userDummyProvider.storeTopCategories(category1, category2);
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
  QuizQuestion('Nature Walks', 'Music'),

  // more questions
];

class CategoryScore {
  String category;
  double score;

  CategoryScore(this.category, this.score);
}
