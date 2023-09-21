import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/quiz_provider.dart';
import 'package:dellminds_mobile_app/screens/community_feed/community_feed.dart';
import 'package:dellminds_mobile_app/screens/community_feed/create_post.dart';
import 'package:dellminds_mobile_app/screens/event/event_all.dart';
import 'package:dellminds_mobile_app/screens/event/event_details.dart';
import 'package:dellminds_mobile_app/screens/home/home_simple.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/forgotPassword.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/screens/login_old/login_old.dart';
import 'package:dellminds_mobile_app/screens/login/signup.dart';
import 'package:dellminds_mobile_app/screens/login/verificationScreen.dart';
import 'package:dellminds_mobile_app/screens/onboarding/welcome.dart';
import 'package:dellminds_mobile_app/screens/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizProvider>(
          create: (context) => QuizProvider(),
        ),
        ChangeNotifierProvider<UserDummyProvider>(
          create: (context) => UserDummyProvider(),
        ),
        ChangeNotifierProvider<EventApi>(
          create: (context) => EventApi(),
        ),
        ChangeNotifierProvider<EventApi>(
          create: (context) => EventApi(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: DesignConstants.debugBanner,
          title: 'BookBud',
          theme: ThemeData(
            fontFamily: 'NunitoSans',
            primarySwatch: DesignConstants.COLOR_THEMEPINK,
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: DesignConstants
                    .COLOR_TEXTDARKPINK, // Change this to your desired text color
              ),
              bodySmall: TextStyle(
                color: const Color.fromARGB(
                    255, 66, 38, 47), // Change this to your desired text color
              ),
            ),
          ),
          home: WelcomePage(),
          routes: {
            SignUpScreen.routeName: (_) {
              return SignUpScreen();
            },
            LoginScreen.routeName: (_) {
              return LoginScreen();
            },
            ForgotPasswordScreen.routeName: (_) {
              return ForgotPasswordScreen();
            },
            VerificationScreen.routeName: (_) {
              return VerificationScreen();
            },
            HomeSimpleScreen.routeName: (_) {
              return HomeSimpleScreen();
            },
            HomeScreen.routeName: (_) {
              return HomeScreen();
            },
            EventsAllScreen.routeName: (_) {
              return EventsAllScreen();
            },
            FullPageEventDetails.routeName: (BuildContext context) {
              // Retrieve the arguments passed when navigating to this route
              final args = ModalRoute.of(context)?.settings.arguments;

              if (args is Map<String, dynamic>) {
                // Extract the data from the arguments map
                final event = args['event'] as Event?;
                final hasSignedUp = args['hasSignedUp'] as bool;
                final inProgress = args['inProgress'] as bool;

                return FullPageEventDetails(
                  event: event,
                  hasSignedUp: hasSignedUp,
                  inProgress: inProgress,
                );
              } else {
                // Handle the case when arguments are not provided or are of the wrong type
                // You can return a default or error state here
                return YourErrorWidget();
              }
            },
            ProfileScreen.routeName: (_) {
              return ProfileScreen();
            },
            CommunityFeedScreen.routeName: (_) {
              return CommunityFeedScreen();
            },
            CreatePostScreen.routeName: (_) {
              return CreatePostScreen();
            },
          }),
    );
  }
}

class YourErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'An error occurred.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Please try again later.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Navigate back to the previous screen
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
