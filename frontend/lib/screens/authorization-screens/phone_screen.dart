import 'package:flutter/material.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';

import '../../factories/input_decoration_factory.dart';
import '../registration-screens/confirm_phone_number_screen.dart';
import 'package:sayohat/l10n/app_localizations.dart';

final _phoneTextController = TextEditingController();
final _passwordTextController = TextEditingController();
String? userPhone;
String? userPassword;

class PhoneScreen extends StatelessWidget {
  final void Function(Locale)? onLocaleChanged;
  const PhoneScreen({super.key, this.onLocaleChanged});

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
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.auth_type,
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
      loc.enter_your_phone_number,
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
        controller: _phoneTextController,
        decoration: inputDecorationFactory(
          hintText: loc.phone_number,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          outline: true
        ),
      ),
    );
  }
}

class _AuthorizeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        userPhone = _phoneTextController.text;
        userPassword = _passwordTextController.text;
        if (userPhone?.isEmpty ?? true) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.enter_your_phone_number),
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
      child: Text(
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 26.0,
          fontFamily: 'Roboto',
        ),
        loc.proceed,
      ),
    );
  }
}
