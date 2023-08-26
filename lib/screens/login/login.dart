import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:dellminds_mobile_app/screens/login/login_style.dart';
import 'package:dellminds_mobile_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  LoginScreen({super.key});
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(context) {
    String emailaddress = '';
    String password = '';

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

    void loginHandler() {
      if (_loginFormKey.currentState!.validate()) {
        debugPrint('HAHAHAHA ');
        ScaffoldMessenger.of(context).showSnackBar(
            StatusSnackbar.snackbarStatus(
                textMessage: GlobalConstants
                    .CLIENT_STATUS_MSGS['SUCCESSFUL_LOGIN']
                    .toString()));
        //* Login code here
        //* Redirect to home page
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: Text('Login')),
      //   backgroundColor: Colors.black87,
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(DesignConstants.COLOR_DARKBLUE_PRIMARY),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                //* Logo
                Container(
                  width: LoginStyles.logoWidth,
                  height: LoginStyles.logoHeight,
                  margin: LoginStyles.logoMargin,
                  child: Image.asset('assets/logo/hydrosense_icon.png'),
                ),
                //* Login Text
                Container(
                  margin: LoginStyles.titleContainerMargin,
                  alignment: LoginStyles.titleAlign,
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: LoginStyles.title,
                  ),
                ),
                //* Email Address TextBox
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: InputTextBox(
                    inputTextLabelValue: 'Email Address',
                    onChanged: (text) {
                      debugPrint(text);
                      emailaddress = text;
                    },
                    obscureTextEnabled: true,
                    validator: emailValidator,
                  ),
                ),
                //* Password TextBox
                Container(
                  child: InputTextBox(
                    inputTextLabelValue: 'Password',
                    onChanged: (text) => password = text,
                    validator: passwordValidator,
                    obscureTextEnabled: true,
                  ),
                ),
                //* Forget Password Button
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: const Text(
                      'forget password?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    ),
                    onPressed: () =>
                        debugPrint('Redirecting to forget password page...'),
                  ),
                ),
                //* Submit Button
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: ElevatedButton.icon(
                      onPressed: loginHandler,
                      style: const ButtonStyle(
                        enableFeedback: true,
                        backgroundColor: MaterialStatePropertyAll(
                            Color(LoginStyles.buttonColor)),
                        fixedSize:
                            MaterialStatePropertyAll(LoginStyles.buttonSize),
                        textStyle:
                            MaterialStatePropertyAll(LoginStyles.buttonText),
                      ),
                      label: const Text('Login', style: LoginStyles.buttonText),
                      icon: const Icon(
                        Icons.login_rounded,
                        color: LoginStyles.iconColor,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                //* Continue With Section
                LineWithText(
                  text: 'Continue with',
                  thickness: 2,
                  fontSize: 18,
                  lineColor: Colors.white,
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 25,
                ),
                //* Google and Facebook Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/google-icon.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        onTap: () {
                          debugPrint('Redirecting to google auth');
                        }),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/facebook-icon.png',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      onTap: () => debugPrint('redirecting to facebook auth'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
