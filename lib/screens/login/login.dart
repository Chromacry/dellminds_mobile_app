import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login_style.dart';
import 'package:dellminds_mobile_app/screens/onboarding/onboarding_page_3.dart';
import 'package:dellminds_mobile_app/widgets/input_textbox.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';

class LoginScreen extends StatelessWidget {
  @override
  static const String routeName = '/login';

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email field is empty!';
    }
    // Regular expression to match an email address
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$');

    // Check if the value matches the regular expression
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address!';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password field is empty!';
    }
    return null;
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Full Name field is empty!';
    }
    return null;
  }

  String? phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number field is empty!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/signup.png',
                  width: LoginStyles.logoWidth,
                  height: LoginStyles.logoHeight,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Login here',
                style: LoginStyles.title,
              ),
              Text(
                'Fill up all the boxes to login.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),

              Container(
                margin: LoginStyles.titleContainerMargin,
                child: InputTextBox(
                  inputTextLabelValue: 'Email Address',
                  onChanged: (text) {
                    debugPrint(text);
                  },
                  obscureTextEnabled: true,
                  validator: emailValidator,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: LoginStyles.titleContainerMargin,
                child: InputTextBox(
                  inputTextLabelValue: 'Password',
                  onChanged: (text) {
                    debugPrint(text);
                  },
                  obscureTextEnabled: true,
                  validator: passwordValidator,
                ),
              ),
              SizedBox(height: 10),
              //! TEST FUNCTION ONLY TO BE CHANGED
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage3()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: LoginStyles.buttonColor,
                  minimumSize: LoginStyles.buttonSize,
                ),
                child: Text(
                  'Login',
                  style: LoginStyles.buttonText,
                ),
              ),
              SizedBox(height: 20),
              Text('Don\'t have an account? Sign up here.'),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text(
                  'Sign Up',
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
