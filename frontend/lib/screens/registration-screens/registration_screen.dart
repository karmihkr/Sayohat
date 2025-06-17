import 'package:flutter/material.dart';
import 'package:sayohat/screens/registration-screens/confirm_phone_number_screen.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/widgets/app_name.dart';
import 'package:sayohat/widgets/app_logo.dart';

String? userPhoneNumber;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
        ),
        SizedBox(height: 15.0),
        Container(
          width: 246,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              userPhoneNumber = _textController.text;
              if (userPhoneNumber == "" || userPhoneNumber == null) {
                final phoneNumberSnackBar = SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          'Enter your phone number',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                );
                ScaffoldMessenger.of(context).showSnackBar(phoneNumberSnackBar);
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
