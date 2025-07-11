import 'package:flutter/material.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';
import 'package:sayohat/user_data.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:sayohat/l10n/app_localizations.dart';

final _dateMaskFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'\d')},
);

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
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.error_enter_time;
    }
    final timeParts = value.split(":");

    try {
      final hours = int.parse(timeParts[0]);
      final mins = int.parse(timeParts[1]);
      if (hours >= 24 || mins >= 60) {
        return loc.error_invalid_time;
      }
      return null;
    } catch (e) {
      return loc.error_invalid_time;
    }
  }

  String? _validateDate(String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.error_enter_date;
    }

    final dateParts = value.split('/');
    if (dateParts.length != 3 ||
        dateParts[0].length != 2 ||
        dateParts[1].length != 2 ||
        dateParts[2].length != 4) {
      return loc.error_format_date;
    }

    try {
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final inputDate = DateTime(year, month, day);
      if (inputDate.year != year ||
          inputDate.month != month ||
          inputDate.day != day) {
        return loc.error_invalid_date;
      }

      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final inputDateOnly = DateTime(year, month, day);

      if (inputDateOnly.isBefore(todayDate)) {
        return loc.error_date_past;
      }

      return null;
    } catch (e) {
      return loc.error_invalid_date;
    }
  }

  String? _validatePassengers(String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.error_enter_passengers;
    }
    if (int.tryParse(value) == null) {
      return loc.error_valid_number;
    }
    if (int.parse(value) <= 0) {
      return loc.error_positive_number;
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
    final loc = AppLocalizations.of(context)!;
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
              title: Text(loc.general),
              content: Form(
                key: _stepFormKeys[0],
                child: Column(
                  children: [
                    CityField(
                      key: Key('departureCityField'),
                      label: loc.hint_from,
                      onSaved: (value) => {fromCity = value ?? ''},
                      validator: (value) => value?.isEmpty ?? true ? 'Enter city' : null
                    ),
                    SizedBox(height: 10),
                    CityField(
                      key: Key('arrivalCityField'),
                      label: loc.hint_to,
                      onSaved: (value) => {toCity = value ?? ''},
                      validator: (value) => value?.isEmpty ?? true ? 'Enter city' : null
                    ),
                    SizedBox(height: 10),
                    _DateField(
                      key: Key('dateField'),
                      onSaved: (value) => date = value ?? '',
                      validator: _validateDate,
                    ),
                    SizedBox(height: 10),
                    _PassengerNumberField(
                      key: Key('passengersField'),
                      onSaved: (value) => passengers = value ?? '',
                      validator: _validatePassengers,
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text(loc.ride_details),
              content: Form(
                key: _stepFormKeys[1],
                child: Column(
                  children: [
                    _AddressField(
                      key: Key("departureAddressField"),
                      label: loc.hint_departure_address,
                      onSaved: (value) => addressFrom = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _AddressField(
                      key: Key("arrivalAddressField"),
                      label: loc.hint_destination_address,
                      onSaved: (value) => addressTo = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _TimeField(
                      key: Key("timeField"),
                      onSaved: (value) => time = value ?? '',
                      validator: _validateTime,
                    ),
                    SizedBox(height: 10),
                    _PriceField(onSaved: (value) => price = value ?? ''),
                    SizedBox(height: 10),
                    _DescriptionField(
                      key: Key("descriptionField"),
                      onSaved: (value) => description = value ?? '',
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: Text(loc.car_information),
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
                        loc.button_back,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    key: Key("Next/CompleteButton"),
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                    ),
                    child: Text(
                      _currentStep == 2 ? loc.button_complete : loc.button_next,
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
    final loc = AppLocalizations.of(context)!;
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
      "vehicle_number": carPlate,
    };
    apiClient.request(apiClient.post, "/new/ride", params, <String, String>{});
    yourRides.add(userRide);
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarFactory.createSnackBar(loc.success_ride_added),
    );
  }
}

class CityField extends StatefulWidget {
  final String label;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const CityField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator
  });

  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  final FocusNode _fieldFocusObserver = FocusNode();
  late OverlayEntry _searchWindow;

  @override
  void initState() {
    super.initState();
    _fieldFocusObserver.addListener(() {
      if (!_fieldFocusObserver.hasFocus) {
        _searchWindow.remove();
      }
    });
  }

  OverlayEntry _createSearchWindow() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy + size.height + 5.0,
      width: size.width,
      child: Material(
        elevation: 4.0,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            for (MapEntry<String, String> entry in {})
              ListTile(title: Text(entry.value))
          ],
        ),
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      focusNode: _fieldFocusObserver,
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
        hintText: loc.hint_start_enter_address,
        labelText: widget.label,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: (value) async {
        try {
          _searchWindow.remove();
        } finally {
          if (value.isNotEmpty) {
            _searchWindow = _createSearchWindow();
            Overlay.of(context).insert(_searchWindow);
          }
        }
      }
    );
  }
}

class _AddressField extends StatelessWidget {
  final String label;
  final Function(String?) onSaved;

  const _AddressField({
    super.key,
    required this.label,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_address_short : null,
      onSaved: onSaved,
    );
  }
}

class _DateField extends StatelessWidget {
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const _DateField({
    super.key,
    required this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      inputFormatters: [_dateMaskFormatter],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month, color: AppColors.primaryGreen),
        hintText: loc.hint_date_ddmmyyyy,
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

  const _PassengerNumberField({
    super.key,
    required this.onSaved,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outlined, color: AppColors.primaryGreen),
        hintText: loc.hint_number_of_passengers,
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

  const _TimeField({
    super.key,
    required this.onSaved,
    required this.validator
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      inputFormatters: <TextInputFormatter>[HourMinsFormatter()],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.access_time, color: AppColors.primaryGreen),
        hintText: loc.hint_time_hhmm,
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
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.money, color: AppColors.primaryGreen),
        hintText: loc.hint_price,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_price : null,
      onSaved: onSaved,
      keyboardType: TextInputType.number,
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final Function(String?) onSaved;

  const _DescriptionField({
    super.key,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.info, color: AppColors.primaryGreen),
        hintText: loc.hint_contact_info_rules,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_description : null,
      onSaved: onSaved,
    );
  }
}

class _CarModelField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarModelField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.directions_car, color: AppColors.primaryGreen),
        hintText: loc.hint_car_model,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_car_model : null,
      onSaved: onSaved,
    );
  }
}

class _CarColorField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarColorField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.color_lens, color: AppColors.primaryGreen),
        hintText: loc.hint_car_color,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_car_color : null,
      onSaved: onSaved,
    );
  }
}

class _CarPlateField extends StatelessWidget {
  final Function(String?) onSaved;

  const _CarPlateField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc_outlined, color: AppColors.primaryGreen),
        hintText: loc.hint_car_plate,
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
      validator: (value) => value?.isEmpty ?? true ? loc.error_enter_car_plate : null,
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
    return '${value.substring(0, 2)}:${value.substring(2, 4)}';
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
      if (newText == '00:0') {
        toRender = '';
      } else {
        toRender = pack(complete(unpack(newText)));
      }
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
