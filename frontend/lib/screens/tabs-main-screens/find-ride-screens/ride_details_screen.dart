import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/models/ride_model.dart';
import 'package:sayohat/l10n/app_localizations.dart';

class RideDetailsScreen extends StatelessWidget {
  final Ride ride;

  const RideDetailsScreen({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        //
        title: Text(
          loc.ride_details_title,
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: AppColors.backgroundGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FullName(ride: ride),
            SizedBox(height: 16),
            _Age(ride: ride),
            SizedBox(height: 24),
            _RideDetailsText(),
            Divider(),
            _FromAddress(ride: ride),
            _ToAddress(ride: ride),
            _DateStart(ride: ride),
            _StartTime(ride: ride),
            SizedBox(height: 24),
            _CarDetailsText(),
            Divider(),
            _CarModel(ride: ride),
            _CarColor(ride: ride),
            _CarPlate(ride: ride),
            SizedBox(height: 24),
            _Description(),
            Divider(),
            _DescriptionContent(ride: ride),
            _BookingButton(),
          ],
        ),
      ),
    );
  }
}

class _FullName extends StatelessWidget {
  const _FullName({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    //final loc = AppLocalizations.of(context)!;
    return Text(
      //loc.driver_label(ride.fullName),
      "Mario",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _Age extends StatelessWidget {
  const _Age({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    //final loc = AppLocalizations.of(context)!;
    return Text(
      "30",
      //loc.age_label("${ride.age}"),
      style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
    );
  }
}

class _RideDetailsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.trip_details_heading,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _FromAddress extends StatelessWidget {
  const _FromAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
      title: Text(
        loc.from_address_label(ride.addressFrom),
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _ToAddress extends StatelessWidget {
  const _ToAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
      title: Text(
        loc.to_address_label(ride.addressTo),
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _DateStart extends StatelessWidget {
  const _DateStart({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.calendar_today, color: AppColors.primaryGreen),
      title: Text(
        ride.date,
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _StartTime extends StatelessWidget {
  const _StartTime({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time, color: AppColors.primaryGreen),
      title: Text(
        ride.time,
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _CarDetailsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.car_details_heading,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _CarModel extends StatelessWidget {
  const _CarModel({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListTile(
      //
      leading: Icon(Icons.directions_car, color: AppColors.primaryGreen),
      title: Text(
        loc.model_label(ride.carModel),
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _CarColor extends StatelessWidget {
  const _CarColor({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(Icons.color_lens, color: AppColors.primaryGreen),
      title: Text(
        loc.color_label(ride.carColor),
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _CarPlate extends StatelessWidget {
  const _CarPlate({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(Icons.abc_outlined, color: AppColors.primaryGreen),
      title: Text(
        loc.car_plate_label(ride.carPlate),
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.description_heading,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _DescriptionContent extends StatelessWidget {
  const _DescriptionContent({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.text_fields, color: AppColors.primaryGreen),
      title: Text(
        ride.description,
        style: TextStyle(fontFamily: 'Roboto', color: AppColors.primaryGreen),
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text(
          loc.book_this_ride,
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
