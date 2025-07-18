import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/l10n/app_localizations.dart';

import '../../../factories/input_decoration_factory.dart';
import '../../../models/ride_model.dart';
import '../../../objects/current_user.dart';
import '../../../project_settings.dart';

final _dateMaskFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'\d')},
);

bool isValidDate(String input) {
  if (input == "") {
    return true;
  }
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

bool isValidNameSurname(String input) {
  if (input == "") {
    return true;
  }
  for (int i = 0; i < input.length; i++) {
    if (isNumeric(input[i])) {
      return false;
    }
  }
  return true;
}

bool isValidPhone(String input) {
  if (input == "") {
    return true;
  }
  for (int i = 0; i < input.length; i++) {
    if (input[i] != "+" && !isNumeric(input[i])) {
      return false;
    }
  }
  return true;
}

class EditInfoScreen extends StatefulWidget {
  BuildContext mainContext;

  EditInfoScreen({super.key, required this.mainContext});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  final nameTextController = TextEditingController();
  final surnameTextController = TextEditingController();
  final birthTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      appBar: AppBar(
        title: Text(
          loc.edit_your_profile,
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: AppColors.backgroundGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          bottom: 50.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              loc.label_your_name(currentUser.name!),
              style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
            ),
            SizedBox(height: 10),
            _NameForm(nameTextController: nameTextController),
            Divider(),
            Text(
              loc.label_your_surname(currentUser.surname!),
              style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
            ),
            SizedBox(height: 10),
            _SurnameForm(surnameTextController: surnameTextController),
            Divider(),
            Text(
              loc.label_your_phone_number(currentUser.phone!),
              style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
            ),
            SizedBox(height: 10),
            _PhoneNumberForm(phoneTextController: phoneTextController),
            Divider(),
            Text(
              loc.label_your_date_of_birth(
                "${currentUser.day}/${currentUser.month}/${currentUser.year}",
              ),
              style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
            ),
            SizedBox(height: 10),
            _BirthForm(birthTextController: birthTextController),
            Spacer(),
            _ConfirmChanges(
              newName: nameTextController,
              newSurname: surnameTextController,
              newPhone: phoneTextController,
              newBirth: birthTextController,
              mainContext: widget.mainContext,
            ),
          ],
        ),
      ),
    );
  }
}

class _NameForm extends StatelessWidget {
  final TextEditingController nameTextController;

  const _NameForm({required this.nameTextController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        controller: nameTextController,
        decoration: inputDecorationFactory(
          hintText: loc.hint_new_name,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          outline: true,
        ),
      ),
    );
  }
}

class _SurnameForm extends StatelessWidget {
  final TextEditingController surnameTextController;

  const _SurnameForm({required this.surnameTextController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        controller: surnameTextController,
        decoration: inputDecorationFactory(
          hintText: loc.hint_new_surname,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          outline: true,
        ),
      ),
    );
  }
}

class _PhoneNumberForm extends StatelessWidget {
  final TextEditingController phoneTextController;

  const _PhoneNumberForm({required this.phoneTextController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: phoneTextController,
        decoration: inputDecorationFactory(
          hintText: loc.hint_new_phone_number,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          outline: true,
        ),
      ),
    );
  }
}

class _BirthForm extends StatelessWidget {
  final TextEditingController birthTextController;

  const _BirthForm({required this.birthTextController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 200.0,
      height: 40,
      child: TextField(
        inputFormatters: [_dateMaskFormatter],
        controller: birthTextController,
        keyboardType: TextInputType.number,
        decoration: inputDecorationFactory(
          hintText: loc.hint_new_date_of_birth,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          outline: true,
        ),
      ),
    );
  }
}

class _ConfirmChanges extends StatelessWidget {
  bool? nameValidate;
  bool? surnameValidate;
  bool? phoneValidate;
  bool? birthValidate;
  TextEditingController newName;
  TextEditingController newSurname;
  TextEditingController newPhone;
  TextEditingController newBirth;
  BuildContext mainContext;

  _ConfirmChanges({
    required this.newName,
    required this.newSurname,
    required this.newPhone,
    required this.newBirth,
    required this.mainContext,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (!isValidDate(newBirth.text) ||
              !isValidNameSurname(newName.text) ||
              !isValidNameSurname(newSurname.text) ||
              !isValidPhone(newPhone.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.snackbar_something_went_wrong),
            );
            return;
          }
          try {
            await hamsafarApiClient.updateUserProfile(
              newPhone.text,
              newName.text,
              newSurname.text,
              newBirth.text,
            );
            if (newPhone.text.isNotEmpty) currentUser.phone = newPhone.text;
            if (newName.text.isNotEmpty) currentUser.name = newName.text;
            if (newSurname.text.isNotEmpty) {
              currentUser.surname = newSurname.text;
            }
            if (newBirth.text.isNotEmpty) {
              currentUser.year = int.parse(newBirth.text.split('/')[2]);
              currentUser.month = int.parse(newBirth.text.split('/')[1]);
              currentUser.day = int.parse(newBirth.text.split('/')[0]);
            }
            await persistentStorage.setString(
              "currentUser",
              currentUser.toJsonString(),
            );
            List<String> updatedRides = [];
            for (dynamic ride
                in (await persistentStorage.getStringList("currentRides")) ??
                    {}) {
              var gotRide = Ride.fromJsonString(ride);
              gotRide.driverName = newName.text;
              gotRide.driverSurname = newSurname.text;
              updatedRides.add(gotRide.toJsonString());
            }
            await persistentStorage.setStringList("currentRides", updatedRides);
            (mainContext as Element).markNeedsBuild();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar(loc.snackbar_info_updated),
            );
          } on Exception catch (error) {
            if (error.toString().contains("expired")) {
              Navigator.pushNamed(context, '/PhoneScreen');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar(loc.error_api_unreachable),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
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
          loc.button_confirm_changes,
        ),
      ),
    );
  }
}
