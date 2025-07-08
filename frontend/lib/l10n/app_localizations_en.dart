// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get auth_type => 'Log in & Sign up';

  @override
  String get enter_your_phone_number => 'Enter your phone number';

  @override
  String get phone_number => 'Phone number';

  @override
  String get proceed => 'Proceed';

  @override
  String get is_your_phone_number_correct => 'Is your phone number correct?';

  @override
  String get no_go_back => 'No, go back';

  @override
  String get yes_go_next => 'Yes, go next!';

  @override
  String get error_api_unreachable => 'API unreachable, please contact support';

  @override
  String get fill_in_telegram => 'Fill in Telegram';

  @override
  String get verification_code => 'Verification code';

  @override
  String get hint_code => 'Code';

  @override
  String get button_confirm => 'Confirm';

  @override
  String get error_enter_code => 'Enter the code';

  @override
  String get error_incorrect_or_expired => 'Incorrect or expired code';

  @override
  String get registration => 'Registration';

  @override
  String get enter_name_surname => 'Enter your name and surname';

  @override
  String get hint_name => 'Name';

  @override
  String get hint_surname => 'Surname';

  @override
  String get error_enter_name_surname => 'Enter your name and surname';

  @override
  String get button_go_next => 'Go next!';

  @override
  String get hint_date_of_birth => 'Date of birth';

  @override
  String get button_finish => 'Finish';

  @override
  String get error_add_date_of_birth => 'Add the date of your birth';

  @override
  String get error_valid_date_of_birth => 'Add the valid date of birth';

  @override
  String get general => 'General';

  @override
  String get ride_details => 'Ride details';

  @override
  String get car_information => 'Car information';

  @override
  String get hint_start_enter_address => 'Start enter the address';

  @override
  String get hint_date_ddmmyyyy => 'Date dd/mm/yyyy';

  @override
  String get hint_number_of_passengers => 'Number of passengers';

  @override
  String get hint_time_hhmm => 'Time hh:mm';

  @override
  String get hint_price => 'Price';

  @override
  String get hint_contact_info_rules => 'Contact info, rules etc.';

  @override
  String get hint_car_model => 'Car Model';

  @override
  String get hint_car_color => 'Car color';

  @override
  String get hint_car_plate => 'Car plate';

  @override
  String get button_back => 'Back';

  @override
  String get button_next => 'Next';

  @override
  String get button_complete => 'Complete';

  @override
  String get error_enter_time => 'Enter time';

  @override
  String get error_invalid_time => 'Invalid time';

  @override
  String get error_enter_date => 'Please enter date';

  @override
  String get error_format_date => 'Use dd/mm/yyyy format';

  @override
  String get error_invalid_date => 'Invalid date';

  @override
  String get error_date_past => 'Date cannot be in the past';

  @override
  String get error_enter_passengers => 'Please enter number of passengers';

  @override
  String get error_valid_number => 'Please enter a valid number';

  @override
  String get error_positive_number => 'Number should be positive';

  @override
  String get error_enter_address => 'Please, enter the address';

  @override
  String get error_enter_address_short => 'Enter address';

  @override
  String get error_enter_price => 'Enter price';

  @override
  String get error_enter_description => 'Enter description';

  @override
  String get error_enter_car_model => 'Enter car model';

  @override
  String get error_enter_car_color => 'Enter car color';

  @override
  String get error_enter_car_plate => 'Enter car plate';

  @override
  String get success_ride_added => 'Ride was added successfully!';

  @override
  String get hint_from => 'From';

  @override
  String get hint_to => 'To';

  @override
  String get hint_departure_address => 'Departure address';

  @override
  String get hint_destination_address => 'Destination address';

  @override
  String get please_enter_from => 'Please enter from';

  @override
  String get please_enter_to => 'Please enter to';

  @override
  String get number_should_be_possitive => 'Number should be possitive';

  @override
  String please_enter_field(String fieldName) {
    return 'Please enter $fieldName';
  }

  @override
  String get please_enter_date => 'Please enter date';

  @override
  String get use_ddmmyyyy_format => 'Use dd/mm/yyyy format';

  @override
  String get invalid_date => 'Invalid date';

  @override
  String get date_cannot_be_in_the_past => 'Date cannot be in the past';

  @override
  String get please_enter_number_of_passengers =>
      'Please enter number of passengers';

  @override
  String get please_enter_a_valid_number => 'Please enter a valid number';

  @override
  String get number_should_be_positive => 'Number should be positive';

  @override
  String get button_find_ride => 'Find a ride!';

  @override
  String get no_rides_found =>
      'Sorry, we did not find rides by your preferences, try another city or date';

  @override
  String available_seats(String seats) {
    return 'Available seats: $seats';
  }

  @override
  String cost_r(String cost) {
    return 'Cost: $cost r.';
  }

  @override
  String to_address_label(String address) {
    return 'To: $address';
  }

  @override
  String from_address_label(String address) {
    return 'From: $address';
  }

  @override
  String from_to_cities(String from, String to) {
    return '$from - $to';
  }

  @override
  String date_time(String date, String time) {
    return '$date - $time';
  }

  @override
  String years_old(String age) {
    return '$age years old';
  }

  @override
  String get ride_details_title => 'Ride Details';

  @override
  String driver_label(String fullName) {
    return 'Driver: $fullName';
  }

  @override
  String age_label(String age) {
    return 'Age: $age years';
  }

  @override
  String get trip_details_heading => 'Trip Details';

  @override
  String date_label(String date) {
    return 'Date: $date';
  }

  @override
  String time_label(String time) {
    return 'Time: $time';
  }

  @override
  String get car_details_heading => 'Car Details';

  @override
  String model_label(String carModel) {
    return 'Model: $carModel';
  }

  @override
  String color_label(String carColor) {
    return 'Color: $carColor';
  }

  @override
  String car_plate_label(String carPlate) {
    return 'Car plate: $carPlate';
  }

  @override
  String get description_heading => 'Description';

  @override
  String get book_this_ride => 'Book this ride';

  @override
  String get empty_your_rides =>
      'There you will see list of your rides after adding';

  @override
  String get edit_this_ride => 'Edit this ride';

  @override
  String get error_data_unresolved => 'Data could not be resolved';

  @override
  String get label_phone => 'Phone:';

  @override
  String get label_date_of_birth => 'Date of birth:';

  @override
  String rides_done(String count) {
    return '$count rides were done';
  }

  @override
  String get button_edit_profile => 'Edit profile';

  @override
  String get edit_your_profile => 'Edit your profile';

  @override
  String label_your_name(String name) {
    return 'Your name: $name';
  }

  @override
  String label_your_surname(String surname) {
    return 'Your surname: $surname';
  }

  @override
  String label_your_phone_number(String phone) {
    return 'Your phone number: $phone';
  }

  @override
  String label_your_date_of_birth(String birth) {
    return 'Your date of birth: $birth';
  }

  @override
  String get hint_new_name => 'New name';

  @override
  String get hint_new_surname => 'New surname';

  @override
  String get hint_new_phone_number => 'New phone number';

  @override
  String get hint_new_date_of_birth => 'New date of birth';

  @override
  String get button_confirm_changes => 'Confirm Changes';

  @override
  String get snackbar_info_updated => 'Info updated successfully';

  @override
  String get snackbar_something_went_wrong => 'Something went wrong';

  @override
  String get tab_search => 'Search';

  @override
  String get tab_add => 'Add';

  @override
  String get tab_your_rides => 'Your rides';

  @override
  String get tab_profile => 'Profile';
}
