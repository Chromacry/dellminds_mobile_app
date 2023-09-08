import 'package:dellminds_mobile_app/screens/login/login_style.dart';
import 'package:dellminds_mobile_app/widgets/input_textbox.dart';
import 'package:flutter/material.dart';
import 'package:dellminds_mobile_app/screens/login/login.dart';

class SignUpScreen extends StatelessWidget {
  @override
  static const String routeName = '/signup';

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
                'Create an account',
                style: LoginStyles.title,
              ),
              Text(
                'Hi, kindly fill in the form to proceed',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              // TextFormFields with pink underline
              Container(
                margin: LoginStyles.titleContainerMargin,
                child: InputTextBox(
                  inputTextLabelValue: 'Full Name',
                  onChanged: (text) {
                    debugPrint(text);
                  },
                  obscureTextEnabled: true,
                  validator: nameValidator,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: LoginStyles.titleContainerMargin,
                child: InputTextBox(
                  inputTextLabelValue: 'Phone Number',
                  onChanged: (text) {
                    debugPrint(text);
                  },
                  obscureTextEnabled: true,
                  validator: phoneValidator,
                ),
              ),
              SizedBox(height: 10),
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
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  primary: LoginStyles.buttonColor,
                  minimumSize: LoginStyles.buttonSize,
                ),
                child: Text(
                  'Sign Up',
                  style: LoginStyles.buttonText,
                ),
              ),
              SizedBox(height: 20),
              Text('Already have an account?'),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: Text(
                  'Login',
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
