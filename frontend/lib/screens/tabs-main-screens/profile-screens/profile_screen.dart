import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/tabs-main-screens/profile-screens/edit_info_screen.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(Locale) onLocaleChanged;

  const ProfileScreen({super.key, required this.onLocaleChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await apiClient.getUserProfile();
      setState(() {
        userData = data;
        isLoading = false;
      });
    } on Exception {
      setState(() {
        userData = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (userData == null) {
      return Center(child: Text(loc.error_data_unresolved));
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(),
          SizedBox(height: 20),
          _NameSurname(name: userData!['name'], surname: userData!['surname']),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PhoneNumber(phone: userData!['phone']),
                  Divider(height: 5, color: AppColors.primaryGreen),
                  SizedBox(height: 10),
                  _DateOfBirth(userDateOfBirth: userData!['birth']),
                  Divider(height: 5, color: AppColors.primaryGreen),
                  SizedBox(height: 20),
                  _StatisticsText(),
                  SizedBox(height: 15),
                  _StatisticsBlocks(),
                  SizedBox(height: 5),
                  Center(
                    child: DropdownButton<Locale>(
                      value: Localizations.localeOf(context),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.language,
                        color: AppColors.primaryGreen,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('EN'),
                        ),
                        DropdownMenuItem(
                          value: Locale('ru'),
                          child: Text('RU'),
                        ),
                        DropdownMenuItem(
                          value: Locale('uk'),
                          child: Text('TG'),
                        ),
                      ],
                      onChanged: (locale) {
                        if (locale != null) {
                          widget.onLocaleChanged(locale);
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  _EditProfileButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: Image.asset(
          'assets/images/test_ava.JPG',
          width: 146,
          height: 146,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _NameSurname extends StatelessWidget {
  final String name;
  final String surname;

  const _NameSurname({required this.name, required this.surname});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$name $surname',
        style: TextStyle(
          fontFamily: 'Roboto',
          color: AppColors.primaryGreen,
          fontSize: 24,
        ),
      ),
    );
  }
}

class _PhoneNumber extends StatelessWidget {
  final String phone;

  const _PhoneNumber({required this.phone});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            loc.label_phone,
            style: const TextStyle(fontSize: 20, color: AppColors.primaryGreen),
          ),
        ),
        Expanded(
          child: Text(
            phone,
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateOfBirth extends StatelessWidget {
  final String userDateOfBirth;

  const _DateOfBirth({required this.userDateOfBirth});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            loc.label_date_of_birth,
            style: const TextStyle(fontSize: 20, color: AppColors.primaryGreen),
          ),
        ),
        Expanded(
          child: Text(
            userDateOfBirth,
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatisticsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        //
        'N rides were done',
        style: const TextStyle(
          color: AppColors.primaryGreen,
          fontSize: 24,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}

class _StatisticsBlocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 141,
          height: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.backgroundGreen,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.people, color: AppColors.primaryGreen, size: 30),
              Text(
                'N',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                //
                'As a passenger',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 141,
          height: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.backgroundGreen,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.car_rental, color: AppColors.primaryGreen, size: 30),
              Text(
                'N',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                //
                'As a driver',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditInfoScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(246, 46),
          backgroundColor: AppColors.primaryGreen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 26.0,
            fontFamily: 'Roboto',
          ),
          loc.button_edit_profile,
        ),
      ),
    );
  }
}
