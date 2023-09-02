import 'package:flutter/material.dart';

//* Event model
class Event {
  final int id;
  final String title;
  final DateTime date;
  final String location;
  final List<String> joinedParticipants;
  final int maxParticipants;
  final String description;
  final String thumbnail;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.joinedParticipants,
    required this.maxParticipants,
    required this.description,
    required this.thumbnail,
  });

  @override
  String toString() {
    return 'Event{id: $id, title: $title, date: $date, location: $location, joinedParticipants: $joinedParticipants, maxParticipants: $maxParticipants, thumbnail: $thumbnail}';
  }
}

class EventProvider extends ChangeNotifier {
  List<Event> _events = [
    Event(
      id: 1,
      title: 'Football Match',
      date: DateTime.now(),
      location: 'Stadium',
      joinedParticipants: [],
      maxParticipants: 20,
      description: 'A friendly football match.',
      thumbnail: 'assets/images/event_images/football.png',
    ),
    Event(
      id: 2,
      title: 'Painting Workshop',
      date: DateTime.now(),
      location: 'Art Studio',
      joinedParticipants: [],
      maxParticipants: 15,
      description: 'Learn to create beautiful paintings.',
      thumbnail: 'assets/images/event_images/painting.jpg',
    ),
    Event(
      id: 3,
      title: 'Nature Walk',
      date: DateTime.now(),
      location: 'Park',
      joinedParticipants: [],
      maxParticipants: 30,
      description: 'Explore the beauty of nature.',
      thumbnail: 'assets/images/event_images/naturewalk.jpg',
    ),
  ];

  List<Event> get events => _events;

  Event? findEventById(int eventId) {
    for (var event in _events) {
      if (event.id == eventId) {
        return event;
      }
    }
    return null;
  }

  void joinEvent(int eventId, String userId) {
    final event = findEventById(eventId);
    if (event != null) {
      if (event.joinedParticipants.length < event.maxParticipants) {
        event.joinedParticipants.add(userId);
        notifyListeners();
      }
    }
  }

  void leaveEvent(int eventId, String userId) {
    final event = findEventById(eventId);
    if (event != null) {
      event.joinedParticipants.remove(userId);
      notifyListeners();
    }
  }
}
