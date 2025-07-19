import 'package:flutter/material.dart';
import 'package:sayohat/screens/registration-screens/confirm_phone_number_screen.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';

import '../../factories/input_decoration_factory.dart';

String? userPhoneNumber;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 250),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AppName(),
              // AppLogo(),
              SizedBox(height: 80),
              _RegistrationText(),
              SizedBox(height: 15.0),
              _PhoneNumberFormAndButton(),
            ],
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

class _PhoneNumberFormAndButton extends StatefulWidget {
  @override
  State<_PhoneNumberFormAndButton> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<_PhoneNumberFormAndButton> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 246,
          height: 46,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _textController,
            decoration: inputDecorationFactory(
              outline: true,
              hintText: "Phone number",
              fillColor: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          width: 246,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              userPhoneNumber = _textController.text;
              if (userPhoneNumber?.isEmpty ?? true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarFactory.createSnackBar("Enter your phone number"),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ConfirmPhoneNumberScreen(phoneNumber: userPhoneNumber),
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
              "Get a code",
            ),
          ),
        ),
      ],
    );
  }
}
