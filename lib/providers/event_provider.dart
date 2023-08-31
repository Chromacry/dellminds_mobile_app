import 'package:dellminds_mobile_app/models/activity.dart';
import 'package:flutter/material.dart';
import 'dart:core';

//* Event model
class Event {
  final String title;
  final DateTime date;
  final Activity activity; // Stores the reference to the activity
  final String location;
  final List<String> joinedParticipants;
  final int maxParticipants;
  final String description;
  final String thumbnail;

  Event(
      this.title,
      this.date,
      this.activity,
      this.location,
      this.joinedParticipants,
      this.maxParticipants,
      this.description,
      this.thumbnail);
}

class EventProvider extends ChangeNotifier {
  List<Event> _events = [
    Event(
      'Football Match',
      DateTime.now(),
      Activity(
          name: 'Football',
          category: Category(name: 'Sports', icon: Icons.sports_soccer)),
      'Stadium',
      [],
      20,
      'A friendly football match.',
      'assets/images/event_images/football.png',
    ),
    Event(
      'Painting Workshop',
      DateTime.now(),
      Activity(
          name: 'Painting',
          category: Category(name: 'Arts', icon: Icons.brush)),
      'Art Studio',
      [],
      15,
      'Learn to create beautiful paintings.',
      'assets/images/event_images/painting.jpg',
    ),
    Event(
      'Nature Walk',
      DateTime.now(),
      Activity(
          name: 'Nature Walk',
          category: Category(name: 'Outdoors', icon: Icons.nature_people)),
      'Park',
      [],
      30,
      'Explore the beauty of nature.',
      'assets/images/event_images/naturewalk.jpg',
    ),
  ];

  List<Event> get events => _events;

  void joinEvent(int eventIndex, String userId) {
    if (eventIndex >= 0 && eventIndex < _events.length) {
      if (_events[eventIndex].joinedParticipants.length <
          _events[eventIndex].maxParticipants) {
        _events[eventIndex].joinedParticipants.add(userId);
        notifyListeners();
      }
    }
  }

  void leaveEvent(int eventIndex, String userId) {
    if (eventIndex >= 0 && eventIndex < _events.length) {
      _events[eventIndex].joinedParticipants.remove(userId);
      notifyListeners();
    }
  }
}
