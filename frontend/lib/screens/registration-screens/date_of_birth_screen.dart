import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/user_data.dart';
import 'package:sayohat/l10n/app_localizations.dart';

bool isValidDate(String input) {
  try {
    final parts = input.split('/');
    if (parts.length != 3) return false;

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    if (day < 1 || day > 31) return false;
    if (month < 1 || month > 12) return false;
    if (year < 1900 || year > DateTime.now().year) return false;

    final dt = DateTime(year, month, day);
    return dt.day == day && dt.month == month && dt.year == year;
  } catch (_) {
    return false;
  }
}

final _birthController = TextEditingController();
String? userBirth;

final _dateMaskFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'\d')},
);

class DateOfBirthScreen extends StatelessWidget {
  const DateOfBirthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGreen,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 250),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                _BirthText(),
                const SizedBox(height: 15),
                _BirthForm(),
                const SizedBox(height: 15),
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
  const _BirthText();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.registration,
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 30,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _BirthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 246,
      height: 46,
      child: TextField(
        controller: _birthController,
        keyboardType: TextInputType.number,
        inputFormatters: [_dateMaskFormatter],
        decoration: InputDecoration(
          hintText: loc.hint_date_of_birth,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
        ),
      ),
    );
  }
}

class _ConfirmBirthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () async {
        userBirth = _birthController.text;
        if (userBirth == null || userBirth!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.error_add_date_of_birth),
          );
          return;
        }
        if (!isValidDate(userBirth!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.error_valid_date_of_birth),
          );
          return;
        }
        user.setBirth(userBirth);
        try {
          await hamsafarApiClient.registerUser(
            user.phone!,
            user.name!,
            user.surname!,
            user.birth!,
          );
          Navigator.pushNamed(context, '/WelcomeHub');
        } on Exception {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarFactory.createSnackBar(loc.error_api_unreachable),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(246, 46),
        backgroundColor: AppColors.primaryGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(
        loc.button_finish,
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 26,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
