import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  @override
  static const String routeName = '/verification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification Code',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF84770),
              ),
            ),
            Text(
              "Email/Mobile verification code has been sent to you",
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 24, // Adjust the font size as needed
                  color: Color(0xFFF84770),
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF84770)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF84770)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Recover password logic
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF84770),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: Text('Recover Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
