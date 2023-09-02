import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  static const String routeName = '/homee';

  @override
  _HomeMapScreenState createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the left position to center the avatar
    double avatarWidth = 170; // Adjust the width of the avatar as needed
    double left = (screenWidth - avatarWidth) / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          //! Real Map API should go here
          ClipRRect(
            child: Image.asset(
              'assets/images/homemap.jpg', // Replace with your map image
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Event cards positioned on the map
          Positioned(
            left: 50, // Adjust the X position as needed
            top: 100, // Adjust the Y position as needed
            child: MapEventCard(
                eventProvider.events[0]), // Replace with your event data
          ),
          Positioned(
            left: 210, // Adjust the X position as needed
            top: 250, // Adjust the Y position as needed
            child: MapEventCard(
                eventProvider.events[1]), // Replace with your event data
          ),
          // Add more Positioned widgets for additional event cards
          Positioned(
            left: left, // Center the avatar horizontally
            top: 370, // Adjust the Y position as needed
            child: Column(
              children: [
                Container(
                  width: avatarWidth,
                  height: avatarWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/youravatar.png', // Replace with your avatar image path
                    width: avatarWidth,
                    height: avatarWidth,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'YOU',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Add a blue button above the navigation bar
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (_) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Simple View',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.event,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: Navigation_Bar(currentIndex: currentIndex),
    );
  }
}

class MapEventCard extends StatelessWidget {
  final Event event;

  MapEventCard(this.event);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final userId = userDummyProvider.userId;

    bool hasJoined = event.joinedParticipants.contains(userId);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => EventModal(event, hasJoined),
        );
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 150, // Adjust the width as needed
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  event.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      DateFormat('EEEE, MMMM d').format(event.date),
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Location: ${event.location}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventModal extends StatelessWidget {
  final Event event;
  final bool hasJoined;

  EventModal(this.event, this.hasJoined);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final userId = userDummyProvider.userId;

    debugPrint('$userId');

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                event.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Adjust the height as needed
              ),
            ),
            SizedBox(height: 16),
            // Title
            Text(
              event.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Date and Location
            // Date and Location
            Text(
              '${DateFormat('EEEE, MMMM d, y').format(event.date)}', // Format the date
              style: TextStyle(fontSize: 16),
            ),

            Text(
              'Location: ${event.location}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Description
            Text(
              event.description,
              style: TextStyle(fontSize: 16),
            ),
            // Joined Participants and Max Participants
            Row(
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
                        '${event.joinedParticipants.length}/${event.maxParticipants}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (hasJoined) {
                  eventProvider.leaveEvent(event.id, userId!);
                } else {
                  eventProvider.joinEvent(event.id, userId!);
                }

                debugPrint('$event');

                // Close the modal after joining or leaving
                Navigator.of(context).pop();
              },
              child: Text(
                hasJoined ? 'Leave Event' : 'Join Event',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

