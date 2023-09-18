import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullPageEventDetails extends StatefulWidget {
  static const String routeName = '/event-details';

  final Event? event;
  final bool hasSignedUp;
  final bool inProgress;

  FullPageEventDetails({
    required this.event,
    required this.hasSignedUp,
    required this.inProgress,
  });

  @override
  _FullPageEventDetailsState createState() => _FullPageEventDetailsState();
}

class _FullPageEventDetailsState extends State<FullPageEventDetails> {
  bool localHasSignedUp = false;
  bool localInProgress = false;

  late YoutubePlayerController _controller;
  late String videoURL; // Declare videoURL as late

  @override
  void initState() {
    // Initialize the local variables with the widget's values
    localHasSignedUp = widget.hasSignedUp;
    localInProgress = widget.inProgress;

    // Video URL will be fetched inside build method
    videoURL = '';

    super.initState();
  }

  // Function to show the introduction video dialog
  void _showIntroductionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Container(
          width: double.infinity,
          height: 300,
          child: YoutubePlayer(
            controller: _controller, // Use the existing controller
            showVideoProgressIndicator: true,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theEventApi = Provider.of<EventApi>(context);
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final userId = userDummyProvider.userId;

    // Fetch videoURL based on the event's activity
    if (videoURL.isEmpty) {
      final activity = widget.event?.activity ?? 'Unknown';
      videoURL =
          Provider.of<EventApi>(context).getYoutubeLinkForActivity(activity);
      final videoID = YoutubePlayer.convertUrlToId(videoURL);

      _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }

    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80.0),

              
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.event?.thumbnail ?? 'No Available',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),

              // Add more vertical space
              SizedBox(height: 16.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.event?.title ?? 'No Available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 52, 6, 35),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        _showIntroductionDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DesignConstants.COLOR_THEMEPINK,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Introduction',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.0),

              // Date and Location
              Text(
                '${DateFormat('EEEE, MMMM d, y').format(widget.event?.date ?? DateTime.now())}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Location: ${widget.event?.location}',
                style: TextStyle(fontSize: 16),
              ),

              // Add more vertical space
              SizedBox(height: 16.0),

              // Description
              Text(
                widget.event?.description ?? 'No Available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 200.0),
              

              Row(
                children: [
                  Text(
                    'Joined Participants',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.all(2.0),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          '${widget.event?.joinedParticipants.length}/${widget.event?.maxParticipants}',
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

              SizedBox(height: 10.0),

              // Event Actions
              Padding(
                padding: EdgeInsets.all(0),
                child: localInProgress
                    ? Text(
                        'Event in progress...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      )
                    : localHasSignedUp
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Leave Event action
                                  theEventApi.leaveEvent(
                                      widget.event!.id, userId!, context);

                                  await Future.delayed(
                                      Duration(milliseconds: 300));

                                  setState(() {
                                    localHasSignedUp = false;
                                    localInProgress = false;
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: Text('You have left the event.'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Leave Event',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  theEventApi.checkInEvent(
                                      widget.event!.id, userId!, context);
                                  await Future.delayed(
                                      Duration(milliseconds: 300));

                                  setState(() {
                                    localInProgress = true;
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: Text(
                                          'You have checked in for the event, have fun!'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Check-in',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              theEventApi.joinEvent(
                                  widget.event!.id, userId!, context);
                              await Future.delayed(Duration(milliseconds: 300));

                              setState(() {
                                localHasSignedUp = true; // Update hasSignedUp
                              });

                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content:
                                      Text('You have signed up for the event!'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Sign Up for Event',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
