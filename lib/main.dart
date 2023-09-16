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
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
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
            LoginScreen.routeName: (_) {
              return LoginScreen();
            },
            SignUpScreen.routeName: (_) {
              return SignUpScreen();
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
