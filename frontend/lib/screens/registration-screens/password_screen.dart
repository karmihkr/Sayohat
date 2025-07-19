import 'package:flutter/material.dart';
import 'package:sayohat/factories/input_decoration_factory.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';

final _passwordTextController = TextEditingController();
final _confirmTextController = TextEditingController();
String? userPassword;
String? userConfirm;

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGreen,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 250),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AppName(),
                // AppLogo(),
                SizedBox(height: 80),
                _RegistationText(),
                _PleaseText(),
                SizedBox(height: 15.0),
                _PasswordCreationForm(),
                SizedBox(height: 15.0),
                _PasswordConfirmForm(),
                SizedBox(height: 15.0),
                _ConfirmPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Registration',
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 30.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _PleaseText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Create and confirm your password',
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 20.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _PasswordCreationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("FormCreation"),
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: _passwordTextController,
        decoration: inputDecorationFactory(
          outline: true,
          hintText: "Password",
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _PasswordConfirmForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("FormConfirm"),
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: _confirmTextController,
        decoration: inputDecorationFactory(
          outline: true,
          hintText: "Confirm the password",
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _ConfirmPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        userPassword = _passwordTextController.text;
        userConfirm = _confirmTextController.text;
        var passwordLength = _passwordTextController.text.length;
        if ((userPassword?.isEmpty ?? true) || (userConfirm?.isEmpty ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar("Fields seem to be empty"),
          );
        } else if (userPassword != userConfirm) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar("Password do not match"),
          );
        } else if (passwordLength < 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(
              "Make a password at least 5 symbols",
            ),
          );
        } else {
          //user.setPasswords(userPassword);
          Navigator.pushNamed(context, '/WelcomeHub');
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(246, 46),
        backgroundColor: AppColors.primaryGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: const Text(
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 26.0,
          fontFamily: 'Roboto',
        ),
        "Complete registation",
      ),
    );
  }
}
