import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/home/home_map.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Simple View Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: eventProvider.events.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final event = eventProvider.events[index];
            return EventCard(event);
          },
        ),
      ),
      bottomNavigationBar: Navigation_Bar(currentIndex: currentIndex),
      extendBody: true, // Allows the FAB to be above the navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeMapScreen.routeName,
                  (_) => false,
                );
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
                    'Map View',
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
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

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
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  event.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${DateFormat('EEEE, MMMM d, y').format(event.date)}', // Format the date
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Location: ${event.location}',
                      style: TextStyle(fontSize: 16),
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
