import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uk'),
  ];

  /// Title on the authentication screen
  ///
  /// In en, this message translates to:
  /// **'Log in & Sign up'**
  String get auth_type;

  /// Prompt asking the user to input their phone number
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enter_your_phone_number;

  /// Label for the phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// Label for the button to proceed after entering phone number
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Prompt asking the user to confirm their phone number
  ///
  /// In en, this message translates to:
  /// **'Is your phone number correct?'**
  String get is_your_phone_number_correct;

  /// Label for the button that returns the user to the previous screen
  ///
  /// In en, this message translates to:
  /// **'No, go back'**
  String get no_go_back;

  /// Label for the button that proceeds to the verification screen
  ///
  /// In en, this message translates to:
  /// **'Yes, go next!'**
  String get yes_go_next;

  /// Error message shown when the backend API cannot be reached
  ///
  /// In en, this message translates to:
  /// **'API unreachable, please contact support'**
  String get error_api_unreachable;

  /// Header prompting the user to fill in their Telegram verification code
  ///
  /// In en, this message translates to:
  /// **'Fill in Telegram'**
  String get fill_in_telegram;

  /// Label for the verification code field
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verification_code;

  /// Hint text inside the verification code input field
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get hint_code;

  /// Label for the button that submits the verification code
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get button_confirm;

  /// Error message shown when the code field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get error_enter_code;

  /// Error message shown when the entered verification code is invalid or expired
  ///
  /// In en, this message translates to:
  /// **'Incorrect or expired code'**
  String get error_incorrect_or_expired;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// Instruction prompting the user to input both name and surname
  ///
  /// In en, this message translates to:
  /// **'Enter your name and surname'**
  String get enter_name_surname;

  /// Hint text inside the name input field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get hint_name;

  /// Hint text inside the surname input field
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get hint_surname;

  /// Error shown when either name or surname is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your name and surname'**
  String get error_enter_name_surname;

  /// Label for the button to proceed to the next screen
  ///
  /// In en, this message translates to:
  /// **'Go next!'**
  String get button_go_next;

  /// Hint text inside the date of birth input field
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get hint_date_of_birth;

  /// Label for the button that completes the birth registration step
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get button_finish;

  /// Error shown when the date of birth field is left empty
  ///
  /// In en, this message translates to:
  /// **'Add the date of your birth'**
  String get error_add_date_of_birth;

  /// Error shown when the entered date of birth is invalid
  ///
  /// In en, this message translates to:
  /// **'Add the valid date of birth'**
  String get error_valid_date_of_birth;

  /// Title of the first step in the Add Ride stepper
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Title of the second step in the Add Ride stepper
  ///
  /// In en, this message translates to:
  /// **'Ride details'**
  String get ride_details;

  /// Title of the third step in the Add Ride stepper
  ///
  /// In en, this message translates to:
  /// **'Car information'**
  String get car_information;

  /// Hint text for the city autocomplete field
  ///
  /// In en, this message translates to:
  /// **'Start enter the address'**
  String get hint_start_enter_address;

  /// Hint text for the date input field in dd/mm/yyyy format
  ///
  /// In en, this message translates to:
  /// **'Date dd/mm/yyyy'**
  String get hint_date_ddmmyyyy;

  /// Hint text for the passengers input field
  ///
  /// In en, this message translates to:
  /// **'Number of passengers'**
  String get hint_number_of_passengers;

  /// Hint text for the time input field in hh:mm format
  ///
  /// In en, this message translates to:
  /// **'Time hh:mm'**
  String get hint_time_hhmm;

  /// Hint text for the price input field
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get hint_price;

  /// Hint text for the ride description input field
  ///
  /// In en, this message translates to:
  /// **'Contact info, rules etc.'**
  String get hint_contact_info_rules;

  /// Hint text for the car model input field
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get hint_car_model;

  /// Hint text for the car color input field
  ///
  /// In en, this message translates to:
  /// **'Car color'**
  String get hint_car_color;

  /// Hint text for the car plate input field
  ///
  /// In en, this message translates to:
  /// **'Car plate'**
  String get hint_car_plate;

  /// Label for the Back button in the stepper controls
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get button_back;

  /// Label for the Next button in the stepper controls
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get button_next;

  /// Label for the Complete button in the stepper controls
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get button_complete;

  /// Validation message when time field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter time'**
  String get error_enter_time;

  /// Validation message when time value is out of range or malformed
  ///
  /// In en, this message translates to:
  /// **'Invalid time'**
  String get error_invalid_time;

  /// Validation message when date field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter date'**
  String get error_enter_date;

  /// Validation message when date string format is incorrect
  ///
  /// In en, this message translates to:
  /// **'Use dd/mm/yyyy format'**
  String get error_format_date;

  /// Validation message when date value is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get error_invalid_date;

  /// Validation message when the chosen date is before today
  ///
  /// In en, this message translates to:
  /// **'Date cannot be in the past'**
  String get error_date_past;

  /// Validation message when passengers field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter number of passengers'**
  String get error_enter_passengers;

  /// Validation message when passengers value is not a number
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get error_valid_number;

  /// Validation message when passengers value is zero or negative
  ///
  /// In en, this message translates to:
  /// **'Number should be positive'**
  String get error_positive_number;

  /// Validation message when address field is empty
  ///
  /// In en, this message translates to:
  /// **'Please, enter the address'**
  String get error_enter_address;

  /// No description provided for @error_enter_address_short.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get error_enter_address_short;

  /// Validation message when price field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter price'**
  String get error_enter_price;

  /// Validation message when description field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter description'**
  String get error_enter_description;

  /// No description provided for @error_enter_car_model.
  ///
  /// In en, this message translates to:
  /// **'Enter car model'**
  String get error_enter_car_model;

  /// No description provided for @error_enter_car_color.
  ///
  /// In en, this message translates to:
  /// **'Enter car color'**
  String get error_enter_car_color;

  /// No description provided for @error_enter_car_plate.
  ///
  /// In en, this message translates to:
  /// **'Enter car plate'**
  String get error_enter_car_plate;

  /// Snackbar message shown when a new ride has been added successfully
  ///
  /// In en, this message translates to:
  /// **'Ride was added successfully!'**
  String get success_ride_added;

  /// No description provided for @hint_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get hint_from;

  /// No description provided for @hint_to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get hint_to;

  /// No description provided for @hint_departure_address.
  ///
  /// In en, this message translates to:
  /// **'Departure address'**
  String get hint_departure_address;

  /// No description provided for @hint_destination_address.
  ///
  /// In en, this message translates to:
  /// **'Destination address'**
  String get hint_destination_address;

  /// Validation message when the departure city field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter from'**
  String get please_enter_from;

  /// Validation message when the arrival city field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter to'**
  String get please_enter_to;

  /// Validation message when the entered number of passengers is zero or negative (note typo matches code)
  ///
  /// In en, this message translates to:
  /// **'Number should be possitive'**
  String get number_should_be_possitive;

  /// Generic validation message prompting the user to enter a required field
  ///
  /// In en, this message translates to:
  /// **'Please enter {fieldName}'**
  String please_enter_field(String fieldName);

  /// Validation message when the date field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter date'**
  String get please_enter_date;

  /// Validation message when the date string format is incorrect
  ///
  /// In en, this message translates to:
  /// **'Use dd/mm/yyyy format'**
  String get use_ddmmyyyy_format;

  /// Validation message when the date value is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get invalid_date;

  /// Validation message when the chosen date is before today
  ///
  /// In en, this message translates to:
  /// **'Date cannot be in the past'**
  String get date_cannot_be_in_the_past;

  /// Validation message when the passengers field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter number of passengers'**
  String get please_enter_number_of_passengers;

  /// Validation message when the passengers value is not a number
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get please_enter_a_valid_number;

  /// Validation message when the passengers value is zero or negative
  ///
  /// In en, this message translates to:
  /// **'Number should be positive'**
  String get number_should_be_positive;

  /// No description provided for @button_find_ride.
  ///
  /// In en, this message translates to:
  /// **'Find a ride!'**
  String get button_find_ride;

  /// Message shown when no rides match the search criteria
  ///
  /// In en, this message translates to:
  /// **'Sorry, we did not find rides by your preferences, try another city or date'**
  String get no_rides_found;

  /// Label showing how many seats are available
  ///
  /// In en, this message translates to:
  /// **'Available seats: {seats}'**
  String available_seats(String seats);

  /// Label showing the cost of the ride in rubles
  ///
  /// In en, this message translates to:
  /// **'Cost: {cost} r.'**
  String cost_r(String cost);

  /// Label for the destination address
  ///
  /// In en, this message translates to:
  /// **'To: {address}'**
  String to_address_label(String address);

  /// Label for the departure address
  ///
  /// In en, this message translates to:
  /// **'From: {address}'**
  String from_address_label(String address);

  /// Label showing departure and arrival cities
  ///
  /// In en, this message translates to:
  /// **'{from} - {to}'**
  String from_to_cities(String from, String to);

  /// Label showing the ride date and time
  ///
  /// In en, this message translates to:
  /// **'{date} - {time}'**
  String date_time(String date, String time);

  /// Label showing the driver's age
  ///
  /// In en, this message translates to:
  /// **'{age} years old'**
  String years_old(String age);

  /// AppBar title on the ride details screen
  ///
  /// In en, this message translates to:
  /// **'Ride Details'**
  String get ride_details_title;

  /// Label showing the driver’s full name
  ///
  /// In en, this message translates to:
  /// **'Driver: {fullName}'**
  String driver_label(String fullName);

  /// Label showing the driver’s age in years
  ///
  /// In en, this message translates to:
  /// **'Age: {age} years'**
  String age_label(String age);

  /// Section heading for trip details
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get trip_details_heading;

  /// Label showing the trip date
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String date_label(String date);

  /// Label showing the trip start time
  ///
  /// In en, this message translates to:
  /// **'Time: {time}'**
  String time_label(String time);

  /// Section heading for car details
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get car_details_heading;

  /// Label showing the car model
  ///
  /// In en, this message translates to:
  /// **'Model: {carModel}'**
  String model_label(String carModel);

  /// Label showing the car color
  ///
  /// In en, this message translates to:
  /// **'Color: {carColor}'**
  String color_label(String carColor);

  /// Label showing the car’s plate number
  ///
  /// In en, this message translates to:
  /// **'Car plate: {carPlate}'**
  String car_plate_label(String carPlate);

  /// Section heading for ride description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description_heading;

  /// Label for the button that confirms booking the ride
  ///
  /// In en, this message translates to:
  /// **'Book this ride'**
  String get book_this_ride;

  /// Message shown when the user has no rides in their list
  ///
  /// In en, this message translates to:
  /// **'There you will see list of your rides after adding'**
  String get empty_your_rides;

  /// Label for the button that edits the existing ride
  ///
  /// In en, this message translates to:
  /// **'Edit this ride'**
  String get edit_this_ride;

  /// Message shown when the user profile data could not be loaded
  ///
  /// In en, this message translates to:
  /// **'Data could not be resolved'**
  String get error_data_unresolved;

  /// Label preceding the phone number in the profile screen
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get label_phone;

  /// Label preceding the date of birth in the profile screen
  ///
  /// In en, this message translates to:
  /// **'Date of birth:'**
  String get label_date_of_birth;

  /// Header showing how many rides the user has completed
  ///
  /// In en, this message translates to:
  /// **'{count} rides were done'**
  String rides_done(String count);

  /// Label for the button that navigates to the profile editing screen
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get button_edit_profile;

  /// AppBar title on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Edit your profile'**
  String get edit_your_profile;

  /// Label showing the user's current name
  ///
  /// In en, this message translates to:
  /// **'Your name: {name}'**
  String label_your_name(String name);

  /// Label showing the user's current surname
  ///
  /// In en, this message translates to:
  /// **'Your surname: {surname}'**
  String label_your_surname(String surname);

  /// Label showing the user's current phone number
  ///
  /// In en, this message translates to:
  /// **'Your phone number: {phone}'**
  String label_your_phone_number(String phone);

  /// Label showing the user's current date of birth
  ///
  /// In en, this message translates to:
  /// **'Your date of birth: {birth}'**
  String label_your_date_of_birth(String birth);

  /// Hint text for the new name input field
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get hint_new_name;

  /// Hint text for the new surname input field
  ///
  /// In en, this message translates to:
  /// **'New surname'**
  String get hint_new_surname;

  /// Hint text for the new phone number input field
  ///
  /// In en, this message translates to:
  /// **'New phone number'**
  String get hint_new_phone_number;

  /// Hint text for the new date of birth input field
  ///
  /// In en, this message translates to:
  /// **'New date of birth'**
  String get hint_new_date_of_birth;

  /// Label for the button that submits profile changes
  ///
  /// In en, this message translates to:
  /// **'Confirm Changes'**
  String get button_confirm_changes;

  /// Snackbar message shown when profile information is updated successfully
  ///
  /// In en, this message translates to:
  /// **'Info updated successfully'**
  String get snackbar_info_updated;

  /// Snackbar message shown when an unexpected error occurs
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get snackbar_something_went_wrong;

  /// Label for the Search tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get tab_search;

  /// Label for the Add tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get tab_add;

  /// Label for the Your rides tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Your rides'**
  String get tab_your_rides;

  /// Label for the Profile tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
