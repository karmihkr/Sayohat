import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/objects/current_telegram_request.dart';
import 'package:sayohat/objects/current_user.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';

import 'package:sayohat/l10n/app_localizations.dart';

import '../../models/user_model.dart';

final _codeTextController = TextEditingController();
String? userCode;
bool loading = false;

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
                _ConfirmCodeButton(mainContext: context),
                if (loading) SizedBox(height: 15.0),
                if (loading)
                  Image.asset(
                    "assets/images/loading.gif",
                    height: 50,
                    width: 50,
                  ),
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
  final BuildContext? mainContext;

  const _ConfirmCodeButton({required this.mainContext});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () async {
        loading = true;
        (mainContext as Element).markNeedsBuild();
        userCode = _codeTextController.text;
        if (userCode?.isEmpty ?? true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackBarFactory.createSnackBar(loc.error_enter_code));
          loading = false;
          (mainContext as Element).markNeedsBuild();
          return;
        }
        try {
          String apiAccessToken = await hamsafarApiClient.obtainAccessToken(
            currentUser.phone!,
            currentTelegramRequest.requestId!,
            userCode!,
          );
          persistentSecuredStorage.write(key: "token", value: apiAccessToken);
          try {
            if (await hamsafarApiClient.userExists(currentUser.phone!)) {
              await persistentStorage.setString(
                "currentUser",
                await hamsafarApiClient.getUserProfile(),
              );
              print(await persistentStorage.getString("currentUser"));
              currentUser = User.fromJsonString(await persistentStorage.getString("currentUser"));
              Navigator.pushNamed(context, '/WelcomeHub');
              return;
            }
            Navigator.pushNamed(context, '/NameSurnameScreen');
          } on Exception {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_api_unreachable),
            );
            loading = false;
            (mainContext as Element).markNeedsBuild();
          }
        } on Exception catch (error) {
          if (error.toString().contains("incorrect")) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_incorrect_or_expired),
            );
            loading = false;
            (mainContext as Element).markNeedsBuild();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.error_api_unreachable),
            );
            loading = false;
            (mainContext as Element).markNeedsBuild();
          }
          return;
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
