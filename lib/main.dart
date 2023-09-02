import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/providers/event_provider.dart';
import 'package:dellminds_mobile_app/providers/example_provider.dart';
import 'package:dellminds_mobile_app/providers/quiz_provider.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/home/home_map.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:dellminds_mobile_app/screens/onboarding/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'widgets/navigation_bar.dart';
import 'package:intl/intl.dart';


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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: DesignConstants.debugBanner,
          title: 'BookBud',
          theme: ThemeData(
            primarySwatch: DesignConstants.COLOR_THEMEPINK,
          ),
          home: WelcomePage(),
          routes: {
            LoginScreen.routeName: (_) {
              return LoginScreen();
            },
            HomeScreen.routeName: (_) {
              return HomeScreen();
            },
            HomeMapScreen.routeName: (_) {
              return HomeMapScreen();
            },
          }),
    );
  }
}

