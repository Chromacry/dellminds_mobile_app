import 'package:flutter/foundation.dart';

class UserDummyProvider extends ChangeNotifier {
  String? _userId;
  String? _recommendedCategory;

  String? get userId => _userId;
  String? get recommendedCategory => _recommendedCategory;

  void setUserInfo(String userId, String recommendedCategory) {
    _userId = userId;
    _recommendedCategory = recommendedCategory;
    notifyListeners();
  }
}
