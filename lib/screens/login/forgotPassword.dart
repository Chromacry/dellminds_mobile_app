import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/login/verificationScreen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  static const String routeName = '/forgotPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // Center the image
              child: Image.asset(
                'assets/images/signup.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 50),
            Center(
              // Center the text
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF84770),
                ),
              ),
            ),
            Center(
              child: Text(
                "Enter your email address or phone number below and we'll send you an OTP with instructions on how to change your password",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: Color(0xFFF84770),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email/Phone Number',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF84770)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF84770)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                Navigator.pushNamed(context, VerificationScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF84770),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                      child: Text('Recover Password'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
