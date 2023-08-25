import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/providers/example_provider.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExampleProvider>(
          create: (context) => ExampleProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: DesignConstants.debugBanner,
          title: 'Dell Minds App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
          routes: {
            LoginScreen.routeName: (_) {
              return LoginScreen();
            },
            HomeScreen.routeName: (_) {
              return HomeScreen();
            },
          }),
    );
  }
}
