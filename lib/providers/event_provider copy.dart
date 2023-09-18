// import 'dart:convert';

// import 'package:dellminds_mobile_app/constants/design_constants.dart';
// import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// //* Event model
// class Event {
//   final int id;
//   final String title;
//   final DateTime date;
//   final String location;
//   final List<String> joinedParticipants;
//   final int maxParticipants;
//   final List<String> attendees; // List of user IDs who attended the event
//   final String description;
//   final String thumbnail;
//   final String activity;
//   final String category;

//   Event({
//     required this.id,
//     required this.title,
//     required this.date,
//     required this.location,
//     required this.joinedParticipants,
//     required this.maxParticipants,
//     required this.attendees,
//     required this.description,
//     required this.thumbnail,
//     required this.activity,
//     required this.category,
//   });
// }

// class EventApi extends ChangeNotifier {
//   List<Event> _events = []; // Initialize events as an empty list

//   List<Event> get events => _events;

//   Future<void> fetchEventsFromAPI() async {
//     final url = 'your_api_endpoint_here'; // Replace with your API endpoint
//     final response = await http.post(
//       Uri.parse(url),
//       body: {
//         // Add any necessary request parameters here
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<Event> fetchedEvents =
//           []; // Create a list to store fetched events

//       for (final eventData in data) {
//         final event = Event(
//           // Create an Event object from the fetched data
//           id: eventData['id'],
//           title: eventData['title'],
//           date: DateTime.parse(eventData['date']),
//           location: eventData['location'],
//           activity: '',
//           attendees: [],
//           category: '',
//           description: '',
//           joinedParticipants: [],
//           maxParticipants: 0,
//           thumbnail: '',
//           // ... (other event properties)
//         );
//         fetchedEvents.add(event); // Add the event to the list
//       }

//       _events = fetchedEvents; // Update the events list with fetched events
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load events from API');
//     }
//   }
//   //*Recommended Events

//   List<Event> _recommendedEvents = [];

//   List<Event> get recommendedEvents => _recommendedEvents;

//   Future<List<Event>> fetchRecommendedEvents(
//       String topCategory1, String topCategory2) async {
//     _recommendedEvents = getRecommendedEvents(topCategory1, topCategory2);

//     print(_recommendedEvents);

//     notifyListeners();

//     return _recommendedEvents;
//   }

// //*

//   List<Event> getRecommendedEvents(String topCategory1, String topCategory2) {
//     print(topCategory1);

//     // Check if topCategory2 is valid (not "None")
//     if (topCategory2 != "None") {
//       return _events
//           .where((event) =>
//               event.category == topCategory1 || event.category == topCategory2)
//           .toList();
//     } else {
//       // Only consider topCategory1
//       return _events.where((event) => event.category == topCategory1).toList();
//     }
//   }

//   Event? findEventById(int eventId) {
//     for (var event in _events) {
//       if (event.id == eventId) {
//         return event;
//       }
//     }
//     return null;
//   }

//   void joinEvent(int eventId, String userId, BuildContext context) {
//     final event = findEventById(eventId);
//     final userProvider = Provider.of<UserDummyProvider>(context, listen: false);

//     if (event != null) {
//       if (event.joinedParticipants.length < event.maxParticipants) {
//         event.joinedParticipants.add(userId);
//         userProvider.joinEvent(eventId);

//         notifyListeners();
//       } else {
//         // Show a dialog when the event is full
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             content: Text('The event is full. You cannot join.'),
//           ),
//         );
//       }
//     }
//   }

//   void checkInEvent(int eventId, String userId, BuildContext context) {
//     final event = findEventById(eventId);
//     final userProvider = Provider.of<UserDummyProvider>(context, listen: false);

//     if (event != null) {
//       event.attendees.add(userId);
//       userProvider.completeEvent(eventId);

//       notifyListeners();
//     }
//   }

//   void leaveEvent(int eventId, String userId, BuildContext context) {
//     final event = findEventById(eventId);
//     final userProvider = Provider.of<UserDummyProvider>(context, listen: false);

//     if (event != null) {
//       event.joinedParticipants.remove(userId);
//       userProvider.joinedEvents.remove(eventId);
//       notifyListeners();
//     }
//   }

//   String getYoutubeLinkForCategory(String category) {
//     switch (category) {
//       case 'Football':
//         return 'https://youtu.be/qknP-E-vPQ4?si=JklBNToN-gzsVU5k';
//       case 'Basketball':
//         return 'https://youtu.be/NdmvkBQa7cY?si=k6mPN_wi3zcB0lQuo';
//       case 'Painting':
//         return 'https://youtu.be/LtpvlOlUxi4?si=IFiLywTLChsVbLTa';
//       case 'Music':
//         return 'https://youtu.be/XKfTTHqbk-4?si=GQ91_vv3uETYg8IU';
//       // Add more cases for other categories
//       default:
//         return 'https://www.youtube.com'; // Default link for unknown categories
//     }
//   }
// }

// class EventModal extends StatelessWidget {
//   final Event? event;
//   final bool hasSignedUp;
//   final bool inProgress;

//   EventModal(this.event, this.hasSignedUp, this.inProgress);

//   @override
//   Widget build(BuildContext context) {
//     if (event == null) {
//       return Container(); // Return an empty container if event is null
//     }

//     final theEventApi = Provider.of<EventApi>(context);
//     final userDummyProvider = Provider.of<UserDummyProvider>(context);
//     final userId = userDummyProvider.userId;

//     debugPrint('$userId');

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Container(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             // Thumbnail
//             Container(
//               padding: EdgeInsets.only(bottom: 16), // Apply padding here
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(15),
//                   topLeft: Radius.circular(15),
//                 ),
//                 child: Image.asset(
//                   event?.thumbnail ?? 'No Available',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 200, // Adjust the height as needed
//                 ),
//               ),
//             ),
//             // Title
//             Container(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 16), // Apply padding here
//               child: Text(
//                 event?.title ?? 'No Available',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 52, 6, 35),
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             // Date and Location
//             Container(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 16), // Apply padding here
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${DateFormat('EEEE, MMMM d, y').format(event?.date ?? DateTime.now())}', // Format the date
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Location: ${event?.location}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Container(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 16), // Apply padding here
//               child: Text(
//                 event?.description ?? 'No Available',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: DesignConstants
//                       .COLOR_TEXTDESCRIPTION, // Change to a lighter color, e.g., grey
//                   fontWeight: FontWeight.normal, // Reduce font weight
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Joined Participants and Max Participants
//             Container(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 16), // Apply padding here
//               child: Row(
//                 children: [
//                   Text(
//                     'Joined Participants',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(2.0),
//                     width: 40, // Adjust the size of the circle
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.green, // Use a different color
//                     ),
//                     child: Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           '${event?.joinedParticipants.length}/${event?.maxParticipants}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(12),
//               child: inProgress
//                   ? Text(
//                       'Event in progress...',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.green, // You can choose a suitable color
//                       ),
//                     )
//                   : hasSignedUp
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () async {
//                                 // Leave Event action
//                                 theEventApi.leaveEvent(
//                                     event!.id, userId!, context);

//                                 await Future.delayed(
//                                     Duration(milliseconds: 300));

//                                 // Close the previous dialog
//                                 Navigator.of(context).pop();

//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     content: Text('You have left the event.'),
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Leave Event',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 theEventApi.checkInEvent(
//                                     event!.id, userId!, context);
//                                 await Future.delayed(
//                                     Duration(milliseconds: 300));

//                                 Navigator.of(context).pop();

//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     content: Text(
//                                         'You have checked in for the event, have fun!'),
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Check-in',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : ElevatedButton(
//                           onPressed: () async {
//                             theEventApi.joinEvent(event!.id, userId!, context);

//                             await Future.delayed(Duration(milliseconds: 300));

//                             Navigator.of(context).pop();

//                             showDialog(
//                               context: context,
//                               builder: (ctx) => AlertDialog(
//                                 content:
//                                     Text('You have signed up for the event!'),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child: Text(
//                             'Sign Up for Event',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
