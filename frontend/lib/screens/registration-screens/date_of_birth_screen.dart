import 'package:flutter/material.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/widgets/app_name.dart';
import 'package:sayohat/widgets/app_logo.dart';
import 'package:sayohat/user_data.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

bool isValidDate(String input) {
  try {
    final date = input.split('/');
    if (date.length != 3) return false;

    final day = int.parse(date[0]);
    final month = int.parse(date[1]);
    final year = int.parse(date[2]);

    if (day < 1 || day > 31) return false;
    if (month < 1 || month > 12) return false;
    if (year < 1900 || year > DateTime.now().year) return false;

    final DateTime birthDate = DateTime(year, month, day);
    return birthDate.year == year &&
        birthDate.month == month &&
        birthDate.day == day;
  } catch (e) {
    return false;
  }
}

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
                _BirthText(),
                SizedBox(height: 15.0),
                _BirthForm(),
                SizedBox(height: 15.0),
                _ConfirmBirthButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BirthText extends StatelessWidget {
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

class _BirthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        inputFormatters: [
          DateInputFormatter(),
          //LengthLimitingTextInputFormatter(10),
        ],
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

class _ConfirmBirthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        userBirth = _birthTextController.text;
        if (userBirth?.isEmpty ?? true) {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar("Add the date of your birth"));
        } else if (!isValidDate(userBirth!)) {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar("Add the valid date of birth"));
        } else {
          user.setBirth(userBirth);
          var response = await apiClient.registerNewUser(
              user.phone!, user.name!, user.surname!, user.birth!);
          if (response == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar(
                    "API unreachable, please, contact support"));
            return;
          }
          persistentSecuredStorage.write(key: "token", value: response["access_token"]);
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
        "Finish",
      ),
    );
  }
}
