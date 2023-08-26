import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  HomeScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Home')),
        backgroundColor: Colors.black87,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(DesignConstants.COLOR_DARKBLUE_PRIMARY),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Logout');
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: Text('Logout'),
            )),
      ),
    );
  }
}
