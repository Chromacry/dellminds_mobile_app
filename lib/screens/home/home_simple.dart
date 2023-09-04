import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/event/event_all.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // Adjust the height as needed
        child: AppBar(
            automaticallyImplyLeading: false, 
          backgroundColor: DesignConstants.COLOR_THEMEPINK,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20), // Adjust the radius as needed
            ),
          ),
          title: Row(
            children: [
              Text(
                'Events',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 5), // Add some spacing between the title and the icon
              Icon(
                Icons.list, // Use the map icon here
                color: Colors.white, // You can adjust the icon color
              ),
            ],
          ),
          
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add the header here
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                'Recommended Events',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
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
          ],
        ),
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
                    primary: Colors.grey, // Adjust the color as needed
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

    EventModal myEventModal = EventModal(event, hasJoined);

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
