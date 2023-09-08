// import 'package:dellminds_mobile_app/providers/event_provider.dart';
// import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class FullPageEventDetails extends StatefulWidget {
//   static const String routeName = '/event-details';

//   final Event? event;
//   final bool hasSignedUp;
//   final bool inProgress;

//   FullPageEventDetails({
//      required this.event,
//      required this.hasSignedUp,
//      required this.inProgress,
//   });

//   @override
//   _FullPageEventDetailsState createState() => _FullPageEventDetailsState();
// }


// class _FullPageEventDetailsState extends State<FullPageEventDetails> {
//   @override
//   Widget build(BuildContext context) {
//     final eventProvider = Provider.of<EventProvider>(context);
//     final userDummyProvider = Provider.of<UserDummyProvider>(context);
//     final userId = userDummyProvider.userId;

//     debugPrint('$userId');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Thumbnail
//             Container(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(15),
//                   bottomRight: Radius.circular(15),
//                 ),
//                 child: Image.asset(
//                   widget.event?.thumbnail ?? 'No Available',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 200, // Adjust the height as needed
//                 ),
//               ),
//             ),
//             // Title
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 widget.event?.title ?? 'No Available',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 52, 6, 35),
//                 ),
//               ),
//             ),
//             // Date and Location
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${DateFormat('EEEE, MMMM d, y').format(widget.event?.date ?? DateTime.now())}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Location: ${widget.event?.location}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//             // Description
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 widget.event?.description ?? 'No Available',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             // Joined Participants and Max Participants
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Joined Participants',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(2.0),
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.green,
//                     ),
//                     child: Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           '${widget.event?.joinedParticipants.length}/${widget.event?.maxParticipants}',
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
//             // Event Actions
//             Padding(
//               padding: EdgeInsets.all(12),
//               child: widget.inProgress
//                   ? Text(
//                       'Event in progress...',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.green,
//                       ),
//                     )
//                   : widget.hasSignedUp
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () async {
//                                 // Leave Event action
//                                 eventProvider.leaveEvent(
//                                     widget.event!.id, userId!, context);

//                                 await Future.delayed(
//                                     Duration(milliseconds: 300));

//                                 // Rebuild the widget
//                                 setState(() {});

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
//                                 eventProvider.checkInEvent(
//                                     widget.event!.id, userId!, context);
//                                 await Future.delayed(
//                                     Duration(milliseconds: 300));

//                                 // Rebuild the widget
//                                 setState(() {});

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
//                             eventProvider.joinEvent(
//                                 widget.event!.id, userId!, context);

//                             await Future.delayed(Duration(milliseconds: 300));

//                             // Rebuild the widget
//                             setState(() {});

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
