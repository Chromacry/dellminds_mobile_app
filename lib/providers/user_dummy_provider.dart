import 'package:flutter/foundation.dart';

class UserDummyProvider extends ChangeNotifier {
  String? _userId;
  String topCategory1 = 'None';
  String topCategory2 = 'None';
  String? get userId => _userId;

  Set<int> joinedEvents = {}; // Store event IDs of joined events
  Set<int> completedEvents = {}; // Store event IDs of completed events

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

  void joinEvent(int eventId) {
    joinedEvents.add(eventId);
    notifyListeners();
  }

  void completeEvent(int eventId) {
    completedEvents.add(eventId);
    notifyListeners();
  }
  
}
