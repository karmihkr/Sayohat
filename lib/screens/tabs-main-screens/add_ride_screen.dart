import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';

class AddRideScreen extends StatelessWidget {
  const AddRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FromField(),
            SizedBox(height: 10),
            _ToField(),
            SizedBox(height: 10),
            _DateField(),
            SizedBox(height: 10),
            _PassengerNumberField(),
            SizedBox(height: 10),
            _CarPlateField(),
            SizedBox(height: 30),
            _AddRideButton(),
          ],
        ),
      ),
    );
  }
}

class _FromField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.circle_outlined, color: AppColors.primaryGreen),
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
        hintText: "From",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _ToField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.circle_outlined, color: AppColors.primaryGreen),
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
        hintText: "To",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month, color: AppColors.primaryGreen),
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
        hintText: "Date",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _PassengerNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outlined, color: AppColors.primaryGreen),
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
        hintText: "Number of Passengers",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _CarPlateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc_outlined, color: AppColors.primaryGreen),
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
        hintText: "Car Plate",
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class _AddRideButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
        'Add the ride!',
      ),
    );
  }
}
