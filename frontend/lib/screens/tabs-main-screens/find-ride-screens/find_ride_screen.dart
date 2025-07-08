import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/list_search_screen.dart';
import 'package:sayohat/l10n/app_localizations.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/models/ride_model.dart';

final _dateMaskFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'\d')},
);

class FindRideScreen extends StatefulWidget {
  final Function(bool) onShowSearchList;

  const FindRideScreen({super.key, required this.onShowSearchList});

  @override
  State<FindRideScreen> createState() => _FindRideScreenState();
}

class _FindRideScreenState extends State<FindRideScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();
  final _passengersController = TextEditingController();

  void _handleFindRide() async {
    final loc = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    final from = _fromController.text;
    final to = _toController.text;
    final date = _dateController.text;
    final passengers = int.parse(_passengersController.text);

    final ridesJson = await apiClient.searchRides(
      from: from,
      to: to,
      date: date,
      passengers: passengers,
    );

    if (ridesJson == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.error_search_ride)));
      return;
    }

    final rides = ridesJson.map((m) => Ride.fromJson(m)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ListSearchRideScreen(rides: rides)),
    );
  }

  String? _validateDate(String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.please_enter_date;
    }

    final dateParts = value.split('/');
    if (dateParts.length != 3 ||
        dateParts[0].length != 2 ||
        dateParts[1].length != 2 ||
        dateParts[2].length != 4) {
      return loc.use_ddmmyyyy_format;
    }

    try {
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final inputDate = DateTime(year, month, day);
      if (inputDate.year != year ||
          inputDate.month != month ||
          inputDate.day != day) {
        return loc.invalid_date;
      }

      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final inputDateOnly = DateTime(year, month, day);

      if (inputDateOnly.isBefore(todayDate)) {
        return loc.error_date_past;
      }

      return null;
    } catch (e) {
      return loc.invalid_date;
    }
  }

  String? _validatePassengers(String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.please_enter_number_of_passengers;
    }
    if (int.tryParse(value) == null) {
      return loc.please_enter_a_valid_number;
    }
    if (int.parse(value) <= 0) {
      return loc.number_should_be_possitive;
    }
    return null;
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _dateController.dispose();
    _passengersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FromField(controller: _fromController),
              SizedBox(height: 10),
              _ToField(controller: _toController),
              SizedBox(height: 10),
              _DateField(controller: _dateController, validator: _validateDate),
              SizedBox(height: 10),
              _PassengerNumberField(
                controller: _passengersController,
                validator: _validatePassengers,
              ),
              SizedBox(height: 30),
              _FindRideButton(onPressed: _handleFindRide),
            ],
          ),
        ),
      ),
    );
  }
}

class _FromField extends StatelessWidget {
  final TextEditingController controller;

  const _FromField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: (value) {
        final loc = AppLocalizations.of(context)!;
        if (value == null || value.isEmpty) {
          return loc.please_enter_field(loc.hint_from);
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.circle_outlined, color: AppColors.primaryGreen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        hintText: loc.hint_from,
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _ToField extends StatelessWidget {
  final TextEditingController controller;

  const _ToField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: (value) {
        final loc = AppLocalizations.of(context)!;
        if (value == null || value.isEmpty) {
          return loc.please_enter_field(loc.hint_from);
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.circle_outlined, color: AppColors.primaryGreen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        hintText: loc.hint_to,
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _DateField({required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: [_dateMaskFormatter],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month, color: AppColors.primaryGreen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        hintText: loc.hint_date_ddmmyyyy,
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _PassengerNumberField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _PassengerNumberField({required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outlined, color: AppColors.primaryGreen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
        ),
        hintText: loc.hint_number_of_passengers,
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _FindRideButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _FindRideButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: onPressed,
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
        loc.button_find_ride,
      ),
    );
  }
}
