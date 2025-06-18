import 'package:flutter/material.dart';
import 'package:sayohat/screens/registration-screens/phone_number_screen.dart';
import 'package:sayohat/screens/registration-screens/sms_code_screen.dart';
import 'package:sayohat/screens/registration-screens/name_surname_screen.dart';
import 'package:sayohat/screens/registration-screens/password_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/main_hub_screen.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/welcome_screen.dart';
import 'package:sayohat/screens/authorization-screens/phone_passwords_screen.dart';
import 'package:sayohat/screens/registration-screens/date_of_birth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(color: AppColors.primaryGreen),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Sayohat Demo',
      home: const WelcomeScreen(),
      routes: {
        '/RegistrationScreen': (context) => const RegistrationScreen(),
        '/VerificationScreen': (context) => const VerificationScreen(),
        '/NameSurnameScreen': (context) => const NameSurnameScreen(),
        '/BirthScreen': (context) => const DateOfBirthScreen(),
        '/PasswordScreen': (context) => const PasswordScreen(),
        '/AuthorizationScreen': (context) => const PhonePasswordsScreen(),
        '/WelcomeHub': (context) => const WelcomeHub(),
      },
    );
  }
}
