import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sayohat/api_clients/yandex_api_client.dart';
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/screens/registration-screens/phone_number_screen.dart';
import 'package:sayohat/screens/registration-screens/sms_code_screen.dart';
import 'package:sayohat/screens/registration-screens/name_surname_screen.dart';
import 'package:sayohat/screens/registration-screens/password_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/main_hub_screen.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/authorization-screens/phone_screen.dart';
import 'package:sayohat/screens/registration-screens/date_of_birth_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

String initialRoute = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await persistentStorage.clear();
  // await persistentSecuredStorage.deleteAll();
  initialRoute =
      Jwt.isExpired(
        await persistentSecuredStorage.read(key: "token") ??
            projectSettings.expiredTokenExample,
      )
      ? '/PhoneScreen'
      : '/WelcomeHub';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _setLocale(Locale newLocale) {
    yandexApiClient.currentLocale = newLocale;
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ru'), Locale('uk')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          yandexApiClient.currentLocale = locale;
          return locale;
        }
        yandexApiClient.currentLocale = Locale("en");
        return const Locale('en');
      },
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(color: AppColors.primaryGreen),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'HamSafar',
      initialRoute: initialRoute,
      home: PhoneScreen(onLocaleChanged: _setLocale),
      routes: {
        '/PhoneScreen': (context) => const PhoneScreen(),
        '/RegistrationScreen': (context) => const RegistrationScreen(),
        '/VerificationScreen': (context) => const VerificationScreen(),
        '/NameSurnameScreen': (context) => const NameSurnameScreen(),
        '/BirthScreen': (context) => const DateOfBirthScreen(),
        '/PasswordScreen': (context) => const PasswordScreen(),
        '/WelcomeHub': (context) => WelcomeHub(onLocaleChanged: _setLocale),
      },
    );
  }
}
