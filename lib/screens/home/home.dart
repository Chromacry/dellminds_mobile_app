import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/event/event_all.dart';
import 'package:dellminds_mobile_app/screens/home/home_simple.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the left position to center the avatar
    double avatarWidth = 170; // Adjust the width of the avatar as needed
    double left = (screenWidth - avatarWidth) / 2;

    return Scaffold(
      body: FutureBuilder<List<Event>>(
        future: _initializeProviders(context), // Fetch recommended events
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is loading, you can display a loading indicator
            return Center(
                child:
                    CircularProgressIndicator()); // Replace with your loading widget
          } else if (snapshot.hasError) {
            // If an error occurred, handle it here
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Once the data is loaded, you can access it as snapshot.data
            final recommendedEvents =
                snapshot.data ?? []; // Default to an empty list if data is null

            return Stack(
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
                  child: recommendedEvents.length > 0
                      ? MapEventCard(recommendedEvents[0])
                      : SizedBox(), // Replace with your event data
                ),
                Positioned(
                  left: 210, // Adjust the X position as needed
                  top: 250, // Adjust the Y position as needed
                  child: recommendedEvents.length > 1
                      ? MapEventCard(recommendedEvents[1])
                      : SizedBox(), // Replace with your event data
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
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Navigation_Bar(currentIndex: currentIndex),

      extendBody: true, // Allows the FAB to be above the navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EventsAllScreen.routeName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Adjust the color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'All Events',
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
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      HomeSimpleScreen.routeName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                        Icons.list,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Event>> _initializeProviders(BuildContext context) async {
    final eventProvider = Provider.of<EventProvider>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);

    final topCategory1 = userDummyProvider.topCategory1;
    final topCategory2 = userDummyProvider.topCategory2;

    // Fetch recommended events and return them
    final events =
        await eventProvider.fetchRecommendedEvents(topCategory1, topCategory2);

    return events;
  }
}

class MapEventCard extends StatelessWidget {
  final Event? event; // Accept a nullable Event

  MapEventCard(this.event);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final userId = userDummyProvider.userId;

    bool hasSignedUp = event?.joinedParticipants.contains(userId) ?? false;
    bool inProgress = event?.attendees.contains(userId) ?? false;

    EventModal myEventModal = EventModal(event, hasSignedUp, inProgress);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => myEventModal,
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
              if (event != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    event!.thumbnail,
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
                      event?.title ?? 'No Event',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      event != null
                          ? DateFormat('EEEE, MMMM d').format(event!.date)
                          : 'No Date',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Text(
                      event != null
                          ? 'Location: ${event!.location}'
                          : 'No Location',
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
