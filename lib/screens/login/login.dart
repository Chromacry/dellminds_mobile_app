import 'package:dellminds_mobile_app/screens/login/login_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_3.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/login/forgotPassword.dart';
import 'package:dellminds_mobile_app/screens/login/signup.dart';

class LoginScreen extends StatelessWidget {
  @override
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/signup.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 50),
              Text(
                'Create an account',
                  style: LoginStyles.title,

              ),
              Text(
                'Hi, kindly login to continue',
                style: TextStyle(
                  fontSize: 18,
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
                        labelText: 'Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF84770)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF84770)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                        color: Color(0xFFF84770),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF84770)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF84770)),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: const Color.fromARGB(255, 99, 99, 99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              //! TEST FUNCTION ONLY TO BE CHANGED
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingPage3()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF84770),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // Adjust button size here
                ),
                child: Text('Confirmed'),
              ),
              SizedBox(height: 20),
              Text("Don't have an account?"),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.blue, // Blue text color
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
