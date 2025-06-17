import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/widgets/app_name.dart';
import 'package:sayohat/widgets/app_logo.dart';
import 'package:sayohat/user_data.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

final _birthTextController = TextEditingController();
String? userBirth;

class DateOfBirthScreen extends StatelessWidget {
  const DateOfBirthScreen({super.key});

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
                _VerificationText(),
                SizedBox(height: 15.0),
                _CodeForm(),
                SizedBox(height: 15.0),
                _ConfirmCodeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerificationText extends StatelessWidget {
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

class _CodeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        inputFormatters: [DateInputFormatter()],
        controller: _birthTextController,
        keyboardType: TextInputType.number,
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
          hintText: "Date of birth",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _ConfirmCodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        userBirth = _birthTextController.text;
        if (userBirth == '' || userBirth == null) {
          final emptyCodeSnackBar = SnackBar(
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
                    'Add the date of your birth',
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
          ScaffoldMessenger.of(context).showSnackBar(emptyCodeSnackBar);
        } else {
          user.setBirth(userBirth);
          Navigator.pushNamed(context, '/PasswordScreen');
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
        "Confirm date of birth",
      ),
    );
  }
}
