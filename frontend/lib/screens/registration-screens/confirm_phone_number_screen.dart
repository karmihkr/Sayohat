import 'package:flutter/material.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/objects/current_telegram_request.dart';
import 'package:sayohat/objects/current_user.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/l10n/app_localizations.dart';

late String? phone;
bool loading = false;

class ConfirmPhoneNumberScreen extends StatelessWidget {
  final String? phoneNumber;

  const ConfirmPhoneNumberScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    phone = phoneNumber;
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
                _ConfirmPhoneNumberText(),
                SizedBox(height: 15.0),
                _PhoneNumberForm(),
                SizedBox(height: 15.0),
                _GoBackButton(mainContext: context),
                SizedBox(height: 15.0),
                _GoNextButton(mainContext: context),
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

class _ConfirmPhoneNumberText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.is_your_phone_number_correct,
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 25.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _PhoneNumberForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 246.0,
      height: 46,
      child: Center(
        child: Container(
          color: AppColors.backgroundGreen,
          child: Text(
            phone ?? "",
            style: TextStyle(
              fontSize: 26.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w900,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
      ),
    );
  }
}

class _GoBackButton extends StatelessWidget {
  final BuildContext? mainContext;

  const _GoBackButton({required this.mainContext});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        loading = false;
        (mainContext as Element).markNeedsBuild();
        Navigator.pop(context);
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
        loc.no_go_back,
      ),
    );
  }
}

class _GoNextButton extends StatelessWidget {
  final BuildContext? mainContext;

  const _GoNextButton({required this.mainContext});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () async {
        loading = true;
        (mainContext as Element).markNeedsBuild();
        currentUser.phone = phone;
        try {
          currentTelegramRequest.requestId = await hamsafarApiClient
              .sendTelegramVerificationCode(phone!);
        } on Exception {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.error_api_unreachable),
          );
          loading = false;
          (mainContext as Element).markNeedsBuild();
          return;
        }
        Navigator.pushNamed(context, '/VerificationScreen');
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
        loc.yes_go_next,
      ),
    );
  }
}
