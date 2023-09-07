import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/widgets/category_filter.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsAllScreen extends StatefulWidget {
  const EventsAllScreen({super.key});

  static const String routeName = '/events-all';

  @override
  _EventsAllScreenState createState() => _EventsAllScreenState();
}

class _EventsAllScreenState extends State<EventsAllScreen> {
  String searchText = ''; // Store user's input text for filtering
  String selectedCategory = 'All'; // Initialize with 'All'

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    // Filter the event list based on the user's input text
    final filteredEvents = eventProvider.events.where((event) {
      final eventCategory = event.category;
      final eventTitle = event.title.toLowerCase();
      final searchQuery = searchText.toLowerCase();

      return (selectedCategory == 'All' || eventCategory == selectedCategory) &&
          (eventTitle.contains(searchQuery));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
         title: Row(
            children: [
              Text(
                'Events (All)',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 5), // Add some spacing between the title and the icon
              Icon(
                Icons.event, // Use the map icon here
                color: Colors.white, // You can adjust the icon color
              ),
            ],
          ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 253, 200, 218),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        setState(() {
                          searchText = text;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:10),
                    child: CategoryFilterWidget(
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredEvents.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
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
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: DesignConstants.COLOR_THEMEPINK,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Recommended',
                        style: TextStyle(
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

    bool hasSignedUp = event.joinedParticipants.contains(userId);
    bool inProgress = event.attendees.contains(userId);

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
                      '${DateFormat('EEEE, MMMM d, y').format(event.date)}',
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
