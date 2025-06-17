import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/widgets/app_name.dart';
import 'package:sayohat/widgets/app_logo.dart';

String? userPhoneNumber;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<WelcomeScreen> {
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
      'Welcome',
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 246,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/AuthorizationScreen');
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
              "Log in",
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          width: 246,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/RegistrationScreen');
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
              "Sign up",
            ),
          ),
        ),
      ],
    );
  }
}
