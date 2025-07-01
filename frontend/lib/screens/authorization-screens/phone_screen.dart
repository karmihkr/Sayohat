import 'package:flutter/material.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/widgets/app_name.dart';
import 'package:sayohat/widgets/app_logo.dart';

import '../registration-screens/confirm_phone_number_screen.dart';

final _phoneTextController = TextEditingController();
final _passwordTextController = TextEditingController();
String? userPhone;
String? userPassword;

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 150),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppName(),
              AppLogo(),
              SizedBox(height: 80),
              _AuthorizationnText(),
              _PleaseText(),
              SizedBox(height: 15.0),
              _NameForm(),
              SizedBox(height: 15.0),
              _AuthorizeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthorizationnText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Log in & Sign up',
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
      'Enter your phone number',
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
        controller: _phoneTextController,
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
          hintText: "Phone number",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _AuthorizeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        userPhone = _phoneTextController.text;
        userPassword = _passwordTextController.text;
        if (userPhone?.isEmpty ?? true) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar("Enter your phone number"),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ConfirmPhoneNumberScreen(phoneNumber: userPhone),
            ),
          );
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
        "Proceed",
      ),
    );
  }
}
