import 'package:flutter/material.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';

import '../../user_data.dart';

import 'package:sayohat/l10n/app_localizations.dart';

final _codeTextController = TextEditingController();
String? userCode;

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
                _FillInTelegramText(),
                _VerificationCodeText(),
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

class _FillInTelegramText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.fill_in_telegram,
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 30.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _VerificationCodeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.verification_code,
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
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 246.0,
      height: 46,
      child: TextField(
        controller: _codeTextController,
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
          hintText: loc.hint_code,
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
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () async {
        userCode = _codeTextController.text;
        if (userCode?.isEmpty ?? true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackBarFactory.createSnackBar(loc.error_enter_code));
        } else {
          var telegramValidationResult = await apiClient.checkVericode(
            user.vericodeRequestId!,
            userCode!,
          );
          if (telegramValidationResult == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_api_unreachable),
            );
            return;
          }
          if (!telegramValidationResult) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_incorrect_or_expired),
            );
            return;
          }
          var userExistenceResult = await apiClient.checkUsernameExistance(
            user.phone!,
          );
          if (userExistenceResult == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_api_unreachable),
            );
            return;
          }
          if (userExistenceResult["answer"]) {
            persistentSecuredStorage.write(
              key: "token",
              value: userExistenceResult["access_token"],
            );
            Navigator.pushNamed(context, '/WelcomeHub');
            return;
          }
          Navigator.pushNamed(context, '/NameSurnameScreen');
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
        loc.button_confirm,
      ),
    );
  }
}
