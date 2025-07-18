import 'package:flutter/material.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/objects/current_user.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/l10n/app_localizations.dart';

import '../../factories/input_decoration_factory.dart';

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
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.registration,
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
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.enter_name_surname,
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
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("nameField"),
        controller: _nameTextController,
        decoration: inputDecorationFactory(
          outline: true,
          hintText: loc.hint_name,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _SurnameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        key: Key("surnameField"),
        controller: _surnameTextController,
        decoration: inputDecorationFactory(
          outline: true,
          hintText: loc.hint_surname,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _ConfirmNameSurnameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        userName = _nameTextController.text;
        userSurname = _surnameTextController.text;
        if ((userName?.isEmpty ?? true) || (userSurname?.isEmpty ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.error_enter_name_surname),
          );
        } else {
          currentUser.name = userName;
          currentUser.surname = userSurname;
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
      child: Text(
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 26.0,
          fontFamily: 'Roboto',
        ),
        loc.button_go_next,
      ),
    );
  }
}
