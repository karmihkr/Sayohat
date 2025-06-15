import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/test_data_search_screen.dart';

class RideDetailsScreen extends StatelessWidget {
  final Ride ride;

  const RideDetailsScreen({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: Text('Ride Details', style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Driver: ${ride.fullName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Age: ${ride.age} years',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            Text('Rating: 5.0', style: TextStyle(fontFamily: 'Roboto')),
            SizedBox(height: 24),
            Text(
              'Trip Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
              title: Text(
                'From: ${ride.address1}',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: AppColors.primaryGreen),
              title: Text(
                'To: ${ride.address2}',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: AppColors.primaryGreen,
              ),
              title: Text(
                'Date: ${ride.date.day}.${ride.date.month}.${ride.date.year}',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: AppColors.primaryGreen),
              title: Text(
                'Time: ${ride.date.hour}:${ride.date.min}',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Car Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.directions_car,
                color: AppColors.primaryGreen,
              ),
              title: Text(
                'Model: Toyota Camry',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.color_lens, color: AppColors.primaryGreen),
              title: Text(
                'Color: White',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.text_fields, color: AppColors.primaryGreen),
              title: Text(
                ride.description,
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  'Book this ride',
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
