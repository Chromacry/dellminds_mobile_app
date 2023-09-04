import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/models/activity.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  final String activity;
  final String category;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.joinedParticipants,
    required this.maxParticipants,
    required this.description,
    required this.thumbnail,
    required this.activity,
    required this.category,
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
      activity: 'Football',
      category: 'Sports',
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
      activity: 'Painting',
      category: 'Arts',
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
      activity: 'Nature Walk',
      category: 'Outdoors',
    ),
  ];

  List<Event> get events => _events;

  //*Recommended Events

  List<Event> _recommendedEvents = [];

  List<Event> get recommendedEvents => _recommendedEvents;

  Future<List<Event>> fetchRecommendedEvents(
      String topCategory1, String topCategory2) async {
    _recommendedEvents = getRecommendedEvents(topCategory1, topCategory2);

    print(_recommendedEvents);

    

    notifyListeners();

    return _recommendedEvents;
  }

//*

  List<Event> getRecommendedEvents(String topCategory1, String topCategory2) {
    print(topCategory1);

    // Check if topCategory2 is valid (not "None")
    if (topCategory2 != "None") {
      return _events
          .where((event) =>
              event.category == topCategory1 || event.category == topCategory2)
          .toList();
    } else {
      // Only consider topCategory1
      return _events.where((event) => event.category == topCategory1).toList();
    }
  }

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

class EventModal extends StatelessWidget {
  final Event? event;
  final bool hasJoined;

  EventModal(this.event, this.hasJoined);

  @override
  Widget build(BuildContext context) {
    if (event == null) {
      return Container(); // Return an empty container if event is null
    }

    final eventProvider = Provider.of<EventProvider>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final userId = userDummyProvider.userId;

    debugPrint('$userId');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            // Thumbnail
            Container(
              padding: EdgeInsets.only(bottom: 16), // Apply padding here
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.asset(
                  event?.thumbnail ?? 'No Available',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200, // Adjust the height as needed
                ),
              ),
            ),
            // Title
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16), // Apply padding here
              child: Text(
                event?.title ?? 'No Available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 52, 6, 35),
                ),
              ),
            ),
            SizedBox(height: 8),
            // Date and Location
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16), // Apply padding here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat('EEEE, MMMM d, y').format(event?.date ?? DateTime.now())}', // Format the date
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Location: ${event?.location}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16), // Apply padding here
              child: Text(
                event?.description ?? 'No Available',
                style: TextStyle(
                  fontSize: 16,
                  color: DesignConstants
                      .COLOR_TEXTDESCRIPTION, // Change to a lighter color, e.g., grey
                  fontWeight: FontWeight.normal, // Reduce font weight
                ),
              ),
            ),
            SizedBox(height: 16),

            // Joined Participants and Max Participants
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16), // Apply padding here
              child: Row(
                children: [
                  Text(
                    'Joined Participants',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.all(2.0),
                    width: 40, // Adjust the size of the circle
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Use a different color
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          '${event?.joinedParticipants.length}/${event?.maxParticipants}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8), // Apply padding here
              child: ElevatedButton(
                onPressed: () async {
                  if (hasJoined) {
                    eventProvider.leaveEvent(event!.id, userId!);
                  } else {
                    eventProvider.joinEvent(event!.id, userId!);
                  }

                  // Delay to ensure the previous dialog is dismissed before showing the new one
                  await Future.delayed(Duration(milliseconds: 300));

                  // Close the previous dialog
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Text(hasJoined
                          ? 'You have left the event'
                          : 'You have joined the event'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: hasJoined ? Colors.red : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  hasJoined ? 'Leave Event' : 'Join Event',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
