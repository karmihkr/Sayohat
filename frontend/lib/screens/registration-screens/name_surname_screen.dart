import 'package:flutter/material.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/user_data.dart';

final _nameTextController = TextEditingController();
final _surnameTextController = TextEditingController();
String? userName;
String? userSurname;

class NameSurnameScreen extends StatelessWidget {
  const NameSurnameScreen({super.key});

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
                _RegistrationText(),
                _PleaseText(),
                SizedBox(height: 15.0),
                _NameForm(),
                SizedBox(height: 15.0),
                _SurnameForm(),
                SizedBox(height: 15.0),
                _ConfirmNameSurnameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistrationText extends StatelessWidget {
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
      'Enter your name and surname',
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 20.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _NameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("nameField"),
        controller: _nameTextController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "Name",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _SurnameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("surnameField"),
        controller: _surnameTextController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "Surname",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _ConfirmNameSurnameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        userName = _nameTextController.text;
        userSurname = _surnameTextController.text;
        if ((userName?.isEmpty ?? true) || (userSurname?.isEmpty ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar("Enter your name and surname"),
          );
        } else {
          user.setName(userName);
          user.setSurname(userSurname);
          Navigator.pushNamed(context, '/BirthScreen');
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
        "Go next!",
      ),
    );
  }
}
