import 'package:flutter/material.dart';
import 'package:sayohat/api_clients/yandex_api_client.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';
import 'package:sayohat/user_data.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:sayohat/l10n/app_localizations.dart';

import '../../../models/place_model.dart';

String fromCountry = "";
String fromUri = "";

String fromCity = '';
String toCity = '';
String date = '';
String passengers = '';
String fromAddress = '';
String toAddress = '';
String time = '';
String price = '';
String description = '';
String carModel = '';
String carColor = '';
String carPlate = '';

late final AppLocalizations loc;

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

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
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
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Enter city' : null,
                    ),
                    SizedBox(height: 10),
                    CityField(
                      key: Key('arrivalCityField'),
                      label: loc.hint_to,
                      onSaved: (value) => {toCity = value ?? ''},
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Enter city' : null,
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
                      onSaved: (value) => fromAddress = value ?? '',
                    ),
                    SizedBox(height: 10),
                    _AddressField(
                      key: Key("arrivalAddressField"),
                      label: loc.hint_destination_address,
                      onSaved: (value) => toAddress = value ?? '',
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
      address1: fromAddress,
      address2: toAddress,
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
    // apiClient.request(apiClient.post, "/new/ride", params, <String, String>{});
    yourRides.add(userRide);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(snackBarFactory.createSnackBar(loc.success_ride_added));
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
    required this.validator,
  });

  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  final FocusNode _fieldFocusObserver = FocusNode();
  late OverlayEntry _searchWindow;
  late String actualValue;

  @override
  void initState() {
    super.initState();
    _fieldFocusObserver.addListener(() {
      if (!_fieldFocusObserver.hasFocus) {
        if (fromCountry.isEmpty) fromCity = "";
        try {
          _searchWindow.remove();
        } catch (_) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      focusNode: _fieldFocusObserver,
      decoration: inputDecorationFactory(
        Icons.circle_outlined,
        loc.hint_start_enter_address,
        widget.label,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: (value) async {
        actualValue = value;
        if (value.isEmpty) {
          try {
            _searchWindow.remove();
          } catch (_) {}
          return;
        }
        if (yandexApiClient.suggesting) {
          yandexApiClient.delayedRequest = value;
          return;
        }
        await yandexApiClient.suggestCities(value);
        if (actualValue.isEmpty) return;
        fromCountry = "";
        try {
          _searchWindow.remove();
        } catch (_) {}
        _searchWindow = createSearchWindow(context, yandexApiClient.suggested, (
          String title,
          String subtitle,
          String? uri,
        ) {
          fromCountry = subtitle;
          fromCity = title;
        });
        Overlay.of(context).insert(_searchWindow);
        /*} on Exception {
              print("strawberry exception");
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar(loc.error_api_unreachable),
              );
              return;
            }*/
      },
    );
  }
}

OverlayEntry createSearchWindow(
  BuildContext context,
  List<Place> places,
  void Function(String title, String subtitle, String? uri) onTap,
) {
  RenderBox renderBox = context.findRenderObject()! as RenderBox;
  var size = renderBox.size;
  var offset = renderBox.localToGlobal(Offset.zero);
  return OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy + size.height + 5.0,
      width: size.width,
      child: Material(
        elevation: 4.0,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            for (Place place in places)
              ListTile(
                title: Text(place.title),
                subtitle: Text(place.subtitle),
                onTap: () {
                  onTap(place.title, place.subtitle, place.uri);
                },
              ),
          ],
        ),
      ),
    ),
  );
}

class _AddressField extends StatelessWidget {
  final String label;
  final Function(String?) onSaved;

  const _AddressField({super.key, required this.label, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      decoration: inputDecorationFactory(Icons.location_on, label, label),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_address_short : null,
      onSaved: onSaved,
    );
  }
}

class _DateField extends StatelessWidget {
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const _DateField({super.key, required this.onSaved, this.validator});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      inputFormatters: [_dateMaskFormatter],
      decoration: inputDecorationFactory(
        Icons.calendar_month,
        loc.hint_date_ddmmyyyy,
        loc.date_input_label,
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
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      decoration: inputDecorationFactory(
        Icons.person_outlined,
        loc.hint_number_of_passengers,
        loc.passengers,
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

  const _TimeField({super.key, required this.onSaved, required this.validator});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      inputFormatters: <TextInputFormatter>[HourMinsFormatter()],
      decoration: inputDecorationFactory(
        Icons.access_time,
        loc.hint_time_hhmm,
        loc.time_input_label,
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
      decoration: inputDecorationFactory(
        Icons.money,
        loc.hint_price,
        loc.price_label,
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_price : null,
      onSaved: onSaved,
      keyboardType: TextInputType.number,
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final Function(String?) onSaved;

  const _DescriptionField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      key: key,
      decoration: inputDecorationFactory(
        Icons.info,
        loc.hint_contact_info_rules,
        loc.info,
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_description : null,
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
      decoration: inputDecorationFactory(
        Icons.directions_car,
        loc.hint_car_model,
        loc.car,
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_car_model : null,
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
      decoration: inputDecorationFactory(
        Icons.color_lens,
        loc.hint_car_color,
        loc.hint_car_color,
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_car_color : null,
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
      decoration: inputDecorationFactory(
        Icons.abc_outlined,
        loc.hint_car_plate,
        loc.hint_car_plate,
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_car_plate : null,
      onSaved: onSaved,
    );
  }
}

InputDecoration inputDecorationFactory(
  IconData iconData,
  String hintText,
  String labelText,
) {
  return InputDecoration(
    prefixIcon: Icon(iconData, color: AppColors.primaryGreen),
    hintText: hintText,
    labelText: labelText,
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
  );
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
