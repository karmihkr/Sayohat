import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/api_clients/yandex_api_client.dart';
import 'package:sayohat/factories/snack_bar_factory.dart';
import 'package:sayohat/models/ride_model.dart';
import 'package:sayohat/objects/current_rides.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:sayohat/l10n/app_localizations.dart';

import '../../../factories/input_decoration_factory.dart';
import '../../../factories/search_window_factory.dart';
import '../../../objects/current_user.dart';

String fromCountry = "";
String toCountry = "";
String fromUri = "";
String toUri = "";

String fromCity = '';
String toCity = '';
String fromAddress = '';
String toAddress = '';
String date = '';
String passengers = '';
String time = '';
String price = '';
String description = '';
String carModel = '';
String carColor = '';
String carPlate = '';

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
          onStepContinue: () async {
            if (!(_stepFormKeys[_currentStep].currentState!.validate())) return;
            _stepFormKeys[_currentStep].currentState!.save();
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
              return;
            }
            try {
              if (hamsafarApiClient.registering) return;
              (context as Element).markNeedsBuild();
              await hamsafarApiClient.registerRide(
                fromUri,
                toUri,
                date,
                passengers,
                time,
                price,
                description,
                carModel,
                carColor,
                carPlate,
              );
              (context as Element).markNeedsBuild();
              currentRides.add(
                Ride(
                  id: currentUser.id,
                  driverName: currentUser.name,
                  driverSurname: currentUser.surname,
                  driverPhone: currentUser.phone,
                  fromCountry: fromCountry,
                  fromCity: fromCity,
                  fromStreet: fromAddress,
                  toCountry: toCountry,
                  toCity: toCity,
                  toStreet: toAddress,
                  year: int.parse(date.split('/')[2]),
                  month: int.parse(date.split('/')[1]),
                  day: int.parse(date.split('/')[0]),
                  hours: int.parse(time.split(':')[0]),
                  minutes: int.parse(time.split(':')[1]),
                  passengers: int.parse(passengers),
                  price: double.parse(price),
                  description: description,
                  carModel: carModel,
                  carColor: carColor,
                  carPlate: carPlate,
                ),
              );
              await persistentStorage.setStringList("currentRides", [
                ...?(await persistentStorage.getStringList("currentRides")),
                jsonEncode(currentRides.last.toJsonString()),
              ]);
              setState(() => _currentStep = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar(loc.success_ride_added),
              );
            } catch (error) {
              hamsafarApiClient.registering = false;
              (context as Element).markNeedsBuild();
              if (error.toString().contains("expired")) {
                Navigator.pushNamed(context, '/PhoneScreen');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarFactory.createSnackBar(loc.error_api_unreachable),
                );
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
                    if (yandexApiClient.suggesting)
                      Image.asset(
                        "assets/images/loading.gif",
                        height: 50,
                        width: 50,
                      ),
                    CityField(
                      key: Key('departureCityField'),
                      label: loc.hint_from,
                      hint: loc.hint_city,
                      onSaved: (value) => {fromCity = value ?? ''},
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Enter city' : null,
                      loc: loc,
                      mainContext: context,
                    ),
                    SizedBox(height: 10),
                    CityField(
                      key: Key('arrivalCityField'),
                      label: loc.hint_to,
                      hint: loc.hint_city,
                      onSaved: (value) => {toCity = value ?? ''},
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Enter city' : null,
                      loc: loc,
                      mainContext: context,
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
                    if (yandexApiClient.suggesting)
                      Image.asset(
                        "assets/images/loading.gif",
                        height: 50,
                        width: 50,
                      ),
                    CityField(
                      key: Key('departureAddressField'),
                      label: loc.hint_departure_address,
                      hint: loc.street,
                      onSaved: (value) => fromAddress = value ?? '',
                      validator: (value) => value?.isEmpty ?? true
                          ? loc.error_enter_address_short
                          : null,
                      loc: loc,
                      mainContext: context,
                    ),
                    CityField(
                      key: Key('arrivalAddressField'),
                      label: loc.hint_destination_address,
                      hint: loc.street,
                      onSaved: (value) => toAddress = value ?? '',
                      validator: (value) => value?.isEmpty ?? true
                          ? loc.error_enter_address_short
                          : null,
                      loc: loc,
                      mainContext: context,
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
                    if (hamsafarApiClient.registering)
                      Image.asset(
                        "assets/images/loading.gif",
                        height: 50,
                        width: 50,
                      ),
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
}

class CityField extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final AppLocalizations loc;
  final BuildContext mainContext;

  const CityField({
    super.key,
    required this.hint,
    required this.label,
    required this.onSaved,
    required this.validator,
    required this.loc,
    required this.mainContext,
  });

  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  final FocusNode _fieldFocusObserver = FocusNode();
  OverlayEntry? _searchWindow;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fieldFocusObserver.addListener(() {
      if (!_fieldFocusObserver.hasFocus) {
        if (widget.label == widget.loc.hint_from && fromCountry.isEmpty ||
            widget.label == widget.loc.hint_to && toCountry.isEmpty ||
            widget.label == widget.loc.hint_departure_address &&
                fromUri.isEmpty ||
            widget.label == widget.loc.hint_destination_address &&
                toUri.isEmpty) {
          controller.text = "";
        }
        searchWindowSafeRemove(_searchWindow);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      focusNode: _fieldFocusObserver,
      decoration: inputDecorationFactory(
        prefixIcon: Icons.circle_outlined,
        hintText: widget.hint,
        labelText: widget.label,
        outline: false,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: (value) async {
        if (widget.label == loc.hint_from) {
          fromCountry = "";
          fromCity = "";
        } else if (widget.label == loc.hint_to) {
          toCountry = "";
          toCity = "";
        } else if (widget.label == loc.hint_departure_address) {
          fromUri = "";
        } else if (widget.label == loc.hint_destination_address) {
          toUri = "";
        }
        if (value.isEmpty) {
          searchWindowSafeRemove(_searchWindow);
          return;
        }
        if (yandexApiClient.suggesting) {
          if (widget.label == widget.loc.hint_from ||
              widget.label == widget.loc.hint_to) {
            yandexApiClient.delayedRequest = value;
          } else if (widget.label == widget.loc.hint_departure_address) {
            yandexApiClient.delayedRequest = "$fromCountry, $fromCity, $value";
          } else if (widget.label == widget.loc.hint_destination_address) {
            yandexApiClient.delayedRequest = "$toCountry, $toCity, $value";
          }
          return;
        }
        (widget.mainContext as Element).markNeedsBuild();
        if (widget.label == widget.loc.hint_from ||
            widget.label == widget.loc.hint_to) {
          await yandexApiClient.suggestCities(value);
        } else if (widget.label == widget.loc.hint_departure_address) {
          await yandexApiClient.suggestStreets(
            "$fromCountry, $fromCity, $value",
          );
        } else if (widget.label == widget.loc.hint_destination_address) {
          await yandexApiClient.suggestStreets("$toCountry, $toCity, $value");
        }
        (widget.mainContext as Element).markNeedsBuild();
        if (controller.text.isEmpty) return;
        searchWindowSafeRemove(_searchWindow);
        _searchWindow = searchWindowFactory(
          context,
          yandexApiClient.suggested,
          (String title, String subtitle, String? uri) {
            if (widget.label == loc.hint_from) {
              fromCountry = subtitle;
              fromCity = title;
            } else if (widget.label == loc.hint_to) {
              toCountry = subtitle;
              toCity = title;
            } else if (widget.label == loc.hint_departure_address) {
              fromUri = uri!;
            } else if (widget.label == loc.hint_destination_address) {
              toUri = uri!;
            }
            controller.text = title;
            searchWindowSafeRemove(_searchWindow);
          },
        );
        Overlay.of(context).insert(_searchWindow!);
      },
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
        prefixIcon: Icons.calendar_month,
        hintText: loc.hint_date_ddmmyyyy,
        labelText: loc.date_input_label,
        outline: false
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
        prefixIcon: Icons.person_outlined,
        hintText: loc.hint_number_of_passengers,
        labelText: loc.passengers,
        outline: false
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
        prefixIcon: Icons.access_time,
        hintText: loc.hint_time_hhmm,
        labelText: loc.time_input_label,
        outline: false
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
        prefixIcon: Icons.money,
        hintText: loc.hint_price,
        labelText: loc.price_label,
        outline: false
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
        prefixIcon: Icons.info,
        hintText: loc.hint_contact_info_rules,
        labelText: loc.info,
        outline: false
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
        prefixIcon: Icons.directions_car,
        hintText: loc.hint_car_model,
        labelText: loc.car,
        outline: false
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
        prefixIcon: Icons.color_lens,
        hintText: loc.hint_car_color,
        labelText: loc.hint_car_color,
        outline: false
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
        prefixIcon: Icons.abc_outlined,
        hintText: loc.hint_car_plate,
        labelText: loc.hint_car_plate,
        outline: false
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? loc.error_enter_car_plate : null,
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
