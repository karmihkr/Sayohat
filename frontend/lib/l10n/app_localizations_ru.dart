// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get auth_type => 'Вход и регистрация';

  @override
  String get enter_your_phone_number => 'Введите номер телефона';

  @override
  String get phone_number => 'Номер телефона';

  @override
  String get proceed => 'Продолжить';

  @override
  String get is_your_phone_number_correct => 'Номер телефона верен?';

  @override
  String get no_go_back => 'Нет, вернуться';

  @override
  String get yes_go_next => 'Да, дальше';

  @override
  String get error_api_unreachable =>
      'Сервис недоступен. Свяжитесь с поддержкой';

  @override
  String get fill_in_telegram => 'Введите Telegram-код';

  @override
  String get verification_code => 'Код';

  @override
  String get hint_code => 'Код';

  @override
  String get button_confirm => 'Подтвердить';

  @override
  String get error_enter_code => 'Введите код';

  @override
  String get error_incorrect_or_expired => 'Неверный или истёкший код';

  @override
  String get registration => 'Регистрация';

  @override
  String get enter_name_surname => 'Введите имя и фамилию';

  @override
  String get hint_name => 'Имя';

  @override
  String get hint_surname => 'Фамилия';

  @override
  String get error_enter_name_surname => 'Введите имя и фамилию';

  @override
  String get button_go_next => 'Далее';

  @override
  String get hint_date_of_birth => 'Дата рождения';

  @override
  String get button_finish => 'Готово';

  @override
  String get error_add_date_of_birth => 'Укажите дату рождения';

  @override
  String get error_valid_date_of_birth => 'Введите корректную дату';

  @override
  String get general => 'Общее';

  @override
  String get ride_details => 'Детали поездки';

  @override
  String get car_information => 'Информация об авто';

  @override
  String get hint_start_enter_address => 'Начните ввод адреса';

  @override
  String get hint_date_ddmmyyyy => 'дд/мм/гггг';

  @override
  String get hint_number_of_passengers => 'Кол-во мест';

  @override
  String get hint_time_hhmm => 'чч:мм';

  @override
  String get hint_price => 'Цена';

  @override
  String get hint_contact_info_rules => 'Контактная информация, правила и т.д.';

  @override
  String get hint_car_model => 'Модель авто';

  @override
  String get hint_car_color => 'Цвет авто';

  @override
  String get hint_car_plate => 'Номер авто';

  @override
  String get button_back => 'Назад';

  @override
  String get button_next => 'Далее';

  @override
  String get button_complete => 'Завершить';

  @override
  String get error_enter_time => 'Укажите время';

  @override
  String get error_invalid_time => 'Неверное время';

  @override
  String get error_enter_date => 'Укажите дату';

  @override
  String get error_format_date => 'Используйте дд/мм/гггг';

  @override
  String get error_invalid_date => 'Неправильная дата';

  @override
  String get error_date_past => 'Дата не может быть в прошлом';

  @override
  String get error_enter_passengers => 'Укажите количество мест';

  @override
  String get error_valid_number => 'Введите корректное число';

  @override
  String get error_positive_number => 'Число должно быть положительным';

  @override
  String get error_enter_address => 'Введите адрес';

  @override
  String get error_enter_address_short => 'Введите адрес';

  @override
  String get error_enter_price => 'Укажите стоимость';

  @override
  String get error_enter_description => 'Введите описание';

  @override
  String get error_enter_car_model => 'Укажите модель авто';

  @override
  String get error_enter_car_color => 'Укажите цвет авто';

  @override
  String get error_enter_car_plate => 'Укажите номер авто';

  @override
  String get success_ride_added => 'Поездка успешно добавлена!';

  @override
  String get hint_from => 'Откуда';

  @override
  String get hint_to => 'Куда';

  @override
  String get hint_departure_address => 'Адрес отправления';

  @override
  String get hint_destination_address => 'Адрес назначения';

  @override
  String get please_enter_from => 'Укажите пункт отправления';

  @override
  String get please_enter_to => 'Укажите пункт назначения';

  @override
  String get number_should_be_possitive => 'Число должно быть положительным';

  @override
  String please_enter_field(String fieldName) {
    return 'Пожалуйста, введите $fieldName';
  }

  @override
  String get please_enter_date => 'Укажите дату';

  @override
  String get use_ddmmyyyy_format => 'Используйте дд/мм/гггг';

  @override
  String get invalid_date => 'Неправильная дата';

  @override
  String get date_cannot_be_in_the_past => 'Дата не может быть в прошлом';

  @override
  String get please_enter_number_of_passengers => 'Укажите кол-во мест';

  @override
  String get please_enter_a_valid_number => 'Введите корректное число';

  @override
  String get number_should_be_positive => 'Значение должно быть больше нуля';

  @override
  String get button_find_ride => 'Найти поездку';

  @override
  String get no_rides_found => 'По вашим параметрам ничего не найдено';

  @override
  String available_seats(String seats) {
    return 'Свободных мест: $seats';
  }

  @override
  String cost_r(String cost) {
    return 'Стоимость: $cost р.';
  }

  @override
  String to_address_label(String address) {
    return 'Куда: $address';
  }

  @override
  String from_address_label(String address) {
    return 'Откуда: $address';
  }

  @override
  String from_to_cities(String from, String to) {
    return '$from – $to';
  }

  @override
  String date_time(String date, String time) {
    return '$date – $time';
  }

  @override
  String years_old(String age) {
    return '$age лет';
  }

  @override
  String get ride_details_title => 'Детали поездки';

  @override
  String driver_label(String fullName) {
    return 'Водитель: $fullName';
  }

  @override
  String age_label(String age) {
    return 'Возраст: $age лет';
  }

  @override
  String get trip_details_heading => 'Детали поездки';

  @override
  String date_label(String date) {
    return 'Дата: $date';
  }

  @override
  String time_label(String time) {
    return 'Время: $time';
  }

  @override
  String get car_details_heading => 'Детали авто';

  @override
  String model_label(String carModel) {
    return 'Модель: $carModel';
  }

  @override
  String color_label(String carColor) {
    return 'Цвет: $carColor';
  }

  @override
  String car_plate_label(String carPlate) {
    return 'Номер: $carPlate';
  }

  @override
  String get description_heading => 'Описание';

  @override
  String get book_this_ride => 'Забронировать поездку';

  @override
  String get empty_your_rides => 'Список появится после добавления поездок';

  @override
  String get edit_this_ride => 'Редактировать поездку';

  @override
  String get error_data_unresolved => 'Не удалось загрузить данные';

  @override
  String get label_phone => 'Телефон:';

  @override
  String get label_date_of_birth => 'Дата рождения:';

  @override
  String rides_done(String count) {
    return 'Выполнено поездок: $count';
  }

  @override
  String get button_edit_profile => 'Редактировать профиль';

  @override
  String get edit_your_profile => 'Редактировать профиль';

  @override
  String label_your_name(String name) {
    return 'Ваше имя: $name';
  }

  @override
  String label_your_surname(String surname) {
    return 'Ваша фамилия: $surname';
  }

  @override
  String label_your_phone_number(String phone) {
    return 'Ваш телефон: $phone';
  }

  @override
  String label_your_date_of_birth(String birth) {
    return 'Ваша дата рождения: $birth';
  }

  @override
  String get hint_new_name => 'Новое имя';

  @override
  String get hint_new_surname => 'Новая фамилия';

  @override
  String get hint_new_phone_number => 'Новый телефон';

  @override
  String get hint_new_date_of_birth => 'Новая дата рождения';

  @override
  String get button_confirm_changes => 'Сохранить';

  @override
  String get snackbar_info_updated => 'Данные успешно обновлены';

  @override
  String get snackbar_something_went_wrong => 'Что-то пошло не так';

  @override
  String get tab_search => 'Поиск';

  @override
  String get tab_add => 'Добавить';

  @override
  String get tab_your_rides => 'Мои поездки';

  @override
  String get tab_profile => 'Профиль';
}
