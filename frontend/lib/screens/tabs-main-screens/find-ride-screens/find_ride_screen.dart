import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_data.dart';

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

  void _handleFindRide() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    userSearch = DataSearch(
      _fromController.text,
      _toController.text,
      _dateController.text,
      _passengersController.text,
    );
    widget.onShowSearchList(true);
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter date';
    }

    final dateParts = value.split('/');
    if (dateParts.length != 3 ||
        dateParts[0].length != 2 ||
        dateParts[1].length != 2 ||
        dateParts[2].length != 4) {
      return 'Use dd/mm/yyyy format';
    }

    try {
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final inputDate = DateTime(year, month, day);
      if (inputDate.year != year ||
          inputDate.month != month ||
          inputDate.day != day) {
        return 'Invalid date';
      }

      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final inputDateOnly = DateTime(year, month, day);

      if (inputDateOnly.isBefore(todayDate)) {
        return 'Date cannot be in the past';
      }

      return null;
    } catch (e) {
      return 'Invalid date';
    }
  }

  String? _validatePassengers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter number of passengers';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (int.parse(value) <= 0) {
      return 'Number should be possitive';
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
              _FromField(
                controller: _fromController,
                validator: (value) => _validateRequired(value, 'from'),
              ),
              SizedBox(height: 10),
              _ToField(
                controller: _toController,
                validator: (value) => _validateRequired(value, 'to'),
              ),
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
  final FormFieldValidator<String>? validator;

  const _FromField({required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
        hintText: "From",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _ToField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _ToField({required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
        hintText: "To",
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
    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: [DateInputFormatter()],
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
        hintText: "dd/mm/yyyy",
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
        hintText: "Number of Passengers",
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
        'Find a ride!',
      ),
    );
  }
}
