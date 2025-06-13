import 'package:flutter/material.dart';
import 'package:sayohat/screens/registration-screens/registration_screen.dart';
import 'package:sayohat/screens/registration-screens/verification_screen.dart';
import 'package:sayohat/screens/registration-screens/name_surname_screen.dart';
import 'package:sayohat/screens/registration-screens/password_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sayohat Demo',
      home: const RegistrationScreen(),
      routes: {
        '/RegistrationScreen': (context) => const RegistrationScreen(),
        '/VerificationScreen': (context) => const VerificationScreen(),
        '/NameSurnameScreen': (context) => const NameSurnameScreen(),
        'PasswordScreen': (context) => const PasswordScreen(),
        '/WelcomeScreen': (context) => const WelcomeScreen(),
      },
    );
  }
}
