import 'package:flutter/material.dart';
import 'package:sayohat/api_client.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:sayohat/screens/snack_bar_factory.dart';

bool isValidDate(String input) {
  if (input == "") {
    return true;
  }
  try {
    final date = input.split('/');
    if (date.length != 3) return false;

    final day = int.parse(date[0]);
    final month = int.parse(date[1]);
    final year = int.parse(date[2]);

    if (day < 1 || day > 31) return false;
    if (month < 1 || month > 12) return false;
    if (year < 1900 || year > DateTime.now().year) return false;

    final DateTime birthDate = DateTime(year, month, day);
    return birthDate.year == year &&
        birthDate.month == month &&
        birthDate.day == day;
  } catch (e) {
    return false;
  }
}

bool isValidNameSurname(String input) {
  if (input == "") {
    return true;
  }
  for (int i = 0; i < input.length; i++) {
    if (isNumeric(input[i])) {
      return false;
    }
  }
  return true;
}

bool isValidPhone(String input) {
  if (input == "") {
    return true;
  }
  for (int i = 0; i < input.length; i++) {
    if (input[i] != "+" && !isNumeric(input[i])) {
      return false;
    }
  }
  return true;
}

String? userName;
String? userSurname;
String? userPhone;
String? userBirth;

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  final nameTextController = TextEditingController();

  final surnameTextController = TextEditingController();

  final birthTextController = TextEditingController();

  final phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await apiClient.getUserProfile();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (userData == null) {
      return const Center(child: Text("Data could not be resolved"));
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text(
          'Edit your profile',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your name: ${userData!['name']}",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              ),
              SizedBox(height: 10),
              _NameForm(nameTextController: nameTextController),
              Divider(),
              Text(
                "Your surname: ${userData!['surname']}",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              ),
              SizedBox(height: 10),
              _SurnameForm(surnameTextController: surnameTextController),
              Divider(),
              Text(
                "Your phone number: ${userData!['phone']}",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              ),
              SizedBox(height: 10),
              _PhoneNumberForm(phoneTextController: phoneTextController),
              Divider(),
              Text(
                "Your date of birth: ${userData!['birth']}",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              ),
              SizedBox(height: 10),
              _BirthForm(birthTextController: birthTextController),
              Spacer(),
              _ConfirmChanges(
                newName: nameTextController,
                newSurname: surnameTextController,
                newPhone: phoneTextController,
                newBirth: birthTextController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameForm extends StatelessWidget {
  final TextEditingController nameTextController;

  const _NameForm({required this.nameTextController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        controller: nameTextController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "New name",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _SurnameForm extends StatelessWidget {
  final TextEditingController surnameTextController;

  const _SurnameForm({required this.surnameTextController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        controller: surnameTextController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "New surname",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _PhoneNumberForm extends StatelessWidget {
  final TextEditingController phoneTextController;

  const _PhoneNumberForm({required this.phoneTextController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: phoneTextController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "New phone number",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _BirthForm extends StatelessWidget {
  final TextEditingController birthTextController;

  const _BirthForm({required this.birthTextController});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 40,
      child: TextField(
        inputFormatters: [DateInputFormatter()],
        controller: birthTextController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
          ),
          hintText: "New date of birth",
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class _ConfirmChanges extends StatelessWidget {
  bool? nameValidate;
  bool? surnameValidate;
  bool? phoneValidate;
  bool? birthValidate;
  TextEditingController newName;
  TextEditingController newSurname;
  TextEditingController newPhone;
  TextEditingController newBirth;

  _ConfirmChanges({
    required this.newName,
    required this.newSurname,
    required this.newPhone,
    required this.newBirth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (isValidDate(newBirth.text) &&
              isValidNameSurname(newName.text) &&
              isValidNameSurname(newSurname.text) &&
              isValidPhone(newPhone.text)) {
            Map<String, dynamic>? updatedUserData = await apiClient
                .updateUserProfile(
                  newPhone.text,
                  newName.text,
                  newSurname.text,
                  newBirth.text,
                );
            if (updatedUserData != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar("Info updated successfully"),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFactory.createSnackBar(
                  "API unreachable. Please, contact support",
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarFactory.createSnackBar("Something went wrong"),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
          backgroundColor: AppColors.primaryGreen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: const Text(
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 26.0,
            fontFamily: 'Roboto',
          ),
          "Confirm Changes",
        ),
      ),
    );
  }
}
