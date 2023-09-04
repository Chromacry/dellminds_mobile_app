import 'package:flutter/foundation.dart';

class UserDummyProvider extends ChangeNotifier {
  String? _userId;
  String topCategory1 = 'None';
  String topCategory2 = 'None';
  String? get userId => _userId;

   void storeTopCategories(String category1, String category2) {
    topCategory1 = category1;
    topCategory2 = category2;
    print(topCategory1);
    notifyListeners(); // Notify listeners that the data has changed
  }

  void setUserInfo(String userId, String category1, String category2) {
    _userId = userId;
    topCategory1 = category1;
    topCategory2 = category2;
    notifyListeners();
  }
}
