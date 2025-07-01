import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';

class YourRideDetailsScreen extends StatelessWidget {
  final Ride ride;

  const YourRideDetailsScreen({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text(
          'Your Ride Details',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FullName(ride: ride),
            SizedBox(height: 16),
            _Age(ride: ride),
            _Rating(),
            SizedBox(height: 24),
            _TripDetails(),
            Divider(),
            _FromAddress(ride: ride),
            _ToAddress(ride: ride),
            _RideDate(ride: ride),
            _RideStart(ride: ride),
            SizedBox(height: 24),
            _CarDetailsText(),
            Divider(),
            _CarModel(ride: ride),
            _CarColor(ride: ride),
            _CarPlate(ride: ride),
            SizedBox(height: 24),
            _RideDescription(),
            Divider(),
            _RideDescriptionContext(ride: ride),
            _EditRideButton(),
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
    return Text(
      'Driver: ${ride.fullName}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _Age extends StatelessWidget {
  const _Age({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Age: ${ride.age} years',
      style: TextStyle(fontFamily: 'Roboto'),
    );
  }
}

class _Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Rating: 5.0', style: TextStyle(fontFamily: 'Roboto'));
  }
}

class _TripDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Trip Details',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _FromAddress extends StatelessWidget {
  const _FromAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
      title: Text(
        'From: ${ride.address1}',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class _ToAddress extends StatelessWidget {
  const _ToAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
      title: Text(
        'To: ${ride.address2}',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class _RideDate extends StatelessWidget {
  const _RideDate({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.calendar_today, color: AppColors.primaryGreen),
      title: Text('Date: ${ride.date}', style: TextStyle(fontFamily: 'Roboto')),
    );
  }
}

class _RideStart extends StatelessWidget {
  const _RideStart({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time, color: AppColors.primaryGreen),
      title: Text('Time: ${ride.time}', style: TextStyle(fontFamily: 'Roboto')),
    );
  }
}

class _CarDetailsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Car Details',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _CarModel extends StatelessWidget {
  const _CarModel({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.directions_car, color: AppColors.primaryGreen),
      title: Text(
        'Model: ${ride.carModel}',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class _CarColor extends StatelessWidget {
  const _CarColor({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.color_lens, color: AppColors.primaryGreen),
      title: Text(
        'Color: ${ride.carColor}',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class _CarPlate extends StatelessWidget {
  const _CarPlate({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.abc_outlined, color: AppColors.primaryGreen),
      title: Text(
        'Plate: ${ride.carPlate}',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class _RideDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Description',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class _RideDescriptionContext extends StatelessWidget {
  const _RideDescriptionContext({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.text_fields, color: AppColors.primaryGreen),
      title: Text(ride.description, style: TextStyle(fontFamily: 'Roboto')),
    );
  }
}

class _EditRideButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text(
          'Edit this ride',
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
