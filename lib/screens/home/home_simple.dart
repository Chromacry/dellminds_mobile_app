import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/event/event_all.dart';
import 'package:dellminds_mobile_app/screens/event/event_details.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeSimpleScreen extends StatefulWidget {
  const HomeSimpleScreen({super.key});

  static const String routeName = '/home-simple';

  @override
  _HomeSimpleScreenState createState() => _HomeSimpleScreenState();
}

class _HomeSimpleScreenState extends State<HomeSimpleScreen> {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          //! To get around grey bar ontop of emulator

          Container(
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 16),
            color: DesignConstants.COLOR_THEMEPINK,
          ),

          // Pink Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: DesignConstants.COLOR_THEMEPINK,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Events for you',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // Circular Container Background
          Expanded(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.all(20.0), // Adjust the padding as needed
                child: FutureBuilder<List<Event>>(
                  future: _initializeProviders(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final recommendedEvents = snapshot.data ?? [];

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: recommendedEvents.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                        itemBuilder: (context, index) {
                          final event = recommendedEvents[index];
                          return EventCard(event);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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
                      HomeScreen.routeName,
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
                        'Map View',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.map,
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

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

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
