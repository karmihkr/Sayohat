import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';
import 'package:sayohat/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:math' as math;

class AddRideScreen extends StatefulWidget {
  const AddRideScreen({super.key});

  @override
  State<AddRideScreen> createState() => _AddRideScreenState();
}

class _AddRideScreenState extends State<AddRideScreen> {
  //final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _stepFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter time';
    }
    final timeParts = value.split(":");

    try {
      final hours = int.parse(timeParts[0]);
      final mins = int.parse(timeParts[1]);
      if (hours >= 24 || mins >= 60) {
        return "Invalid time";
      }
      return null;
    } catch (e) {
      return "Invalid time";
    }
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
      return 'Number should be positive';
    }
    return null;
  }

  String fromCity = '';
  String toCity = '';
  String date = '';
  String passengers = '';
  String addressFrom = '';
  String addressTo = '';
  String time = '';
  String price = '';
  String description = '';
  String carModel = '';
  String carColor = '';
  String carPlate = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stepper(
          connectorColor: WidgetStatePropertyAll(AppColors.primaryGreen),
          currentStep: _currentStep,
          onStepContinue: () {
            if (_stepFormKeys[_currentStep].currentState!.validate()) {
              _stepFormKeys[_currentStep].currentState!.save();
              if (_currentStep < 2) {
                setState(() => _currentStep += 1);
              } else {
                _saveRide();
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            }
          },
          steps: [
            Step(
              title: Text('General'),
              content: Form(
                key: _stepFormKeys[0],
                child: Column(
                  children: [
                    _CityField(
                      label: 'From',
                      onSaved: (value) => fromCity = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _CityField(
                      label: 'To',
                      onSaved: (value) => toCity = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _DateField(
                      onSaved: (value) => date = value ?? '',
                      validator: _validateDate,
                    ),
                    SizedBox(height: 10),
                    _PassengerNumberField(
                      onSaved: (value) => passengers = value ?? '',
                      validator: _validatePassengers,
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text('Ride details'),
              content: Form(
                key: _stepFormKeys[1],
                child: Column(
                  children: [
                    _AddressField(
                      label: 'Departure address',
                      onSaved: (value) => addressFrom = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _AddressField(
                      label: 'Destination address',
                      onSaved: (value) => addressTo = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _TimeField(
                      onSaved: (value) => time = value ?? '',
                      validator: _validateTime,
                    ),
                    SizedBox(height: 10),
                    _PriceField(onSaved: (value) => price = value ?? ''),
                    SizedBox(height: 10),
                    _DescriptionField(
                      onSaved: (value) => description = value ?? '',
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: Text('Car information'),
              content: Form(
                key: _stepFormKeys[2],
                child: Column(
                  children: [
                    _CarModelField(onSaved: (value) => carModel = value ?? ''),
                    SizedBox(height: 10),
                    _CarColorField(onSaved: (value) => carColor = value ?? ''),
                    SizedBox(height: 10),
                    _CarPlateField(onSaved: (value) => carPlate = value ?? ''),
                  ],
                ),
              ),
              isActive: _currentStep >= 2,
            ),
          ],
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  if (_currentStep != 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                    ),
                    child: Text(
                      _currentStep == 2 ? 'Complete' : 'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _saveRide() async {
    Ride userRide = Ride(
      fullName: '${user.name} ${user.surname}',
      age: 5,
      from: fromCity,
      to: toCity,
      date: date,
      seats: passengers,
      address1: addressFrom,
      address2: addressTo,
      time: time,
      cost: price,
      description: description,
      carModel: carModel,
      carColor: carColor,
      carPlate: carPlate,
    );
    var params = {
      "driver_id": "1",
      "begin_id": "1",
      "end_id": "1",
      "price": price,
      "available_places": passengers,
      "vehicle_number": "В234ЕЛ",
    };
    var response = await http.post(
      Uri.http("127.0.0.1:8000", "/new/ride", params),
    );
    yourRides.add(userRide);
    final addRideSnackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              'Ride was added successfuly!',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(addRideSnackBar);
  }
}

class _CityField extends StatelessWidget {
  final String label;
  final Function(String?) onSaved;

  const _CityField({required this.label, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
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
        prefixIcon: Icon(Icons.circle_outlined, color: AppColors.primaryGreen),
        hintText: label,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter city' : null,
      onSaved: onSaved,
    );
  }
}

class _AddressField extends StatelessWidget {
  final String label;
  final Function(String?) onSaved;

  const _AddressField({required this.label, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.location_on, color: AppColors.primaryGreen),
        hintText: label,
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter address' : null,
      onSaved: onSaved,
    );
  }
}

class _DateField extends StatelessWidget {
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const _DateField({required this.onSaved, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [DateInputFormatter()],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month, color: AppColors.primaryGreen),
        hintText: 'Date dd/mm/yyyy',
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class _PassengerNumberField extends StatelessWidget {
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const _PassengerNumberField({required this.onSaved, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outlined, color: AppColors.primaryGreen),
        hintText: "Number of passengers",
        filled: true,
        fillColor: Colors.white,
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
      ),
      keyboardType: TextInputType.number,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class _TimeField extends StatelessWidget {
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const _TimeField({required this.onSaved, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[HourMinsFormatter()],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.access_time, color: AppColors.primaryGreen),
        hintText: "Time hh:mm",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class _PriceField extends StatelessWidget {
  final Function(String?) onSaved;

  const _PriceField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.money, color: AppColors.primaryGreen),
        hintText: "Price",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter price' : null,
      onSaved: onSaved,
      keyboardType: TextInputType.number,
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final Function(String?) onSaved;

  const _DescriptionField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.info, color: AppColors.primaryGreen),
        hintText: "Contact info, rules etc.",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter description' : null,
      onSaved: onSaved,
    );
  }
}

class _CarModelField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarModelField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.directions_car, color: AppColors.primaryGreen),
        hintText: "Car Model",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter car model' : null,
      onSaved: onSaved,
    );
  }
}

class _CarColorField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarColorField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.color_lens, color: AppColors.primaryGreen),
        hintText: "Car color",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter car color' : null,
      onSaved: onSaved,
    );
  }
}

class _CarPlateField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarPlateField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc_outlined, color: AppColors.primaryGreen),
        hintText: "Car plate",
        filled: true,
        fillColor: Colors.white,
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
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter car plate' : null,
      onSaved: onSaved,
    );
  }
}

class HourMinsFormatter extends TextInputFormatter {
  late RegExp pattern;
  HourMinsFormatter() {
    pattern = RegExp(r'^[0-9:]+$');
  }

  String pack(String value) {
    if (value.length != 4) return value;
    return value.substring(0, 2) + ':' + value.substring(2, 4);
  }

  String unpack(String value) {
    return value.replaceAll(':', '');
  }

  String complete(String value) {
    if (value.length >= 4) return value;
    final multiplier = 4 - value.length;
    return ('0' * multiplier) + value;
  }

  String limit(String value) {
    if (value.length <= 4) return value;
    return value.substring(value.length - 4, value.length);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!pattern.hasMatch(newValue.text)) return oldValue;

    TextSelection newSelection = newValue.selection;

    String toRender;
    String newText = newValue.text;

    toRender = '';
    if (newText.length < 5) {
      if (newText == '00:0')
        toRender = '';
      else
        toRender = pack(complete(unpack(newText)));
    } else if (newText.length == 6) {
      toRender = pack(limit(unpack(newText)));
    }

    newSelection = newValue.selection.copyWith(
      baseOffset: math.min(toRender.length, toRender.length),
      extentOffset: math.min(toRender.length, toRender.length),
    );

    return TextEditingValue(
      text: toRender,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
