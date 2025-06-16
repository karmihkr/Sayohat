import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/test_data_search_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/ride_details_screen.dart';

class ListSearchRideScreen extends StatelessWidget {
  const ListSearchRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rides.length,
              itemBuilder: (BuildContext context, int index) {
                final ride = rides[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RideDetailsScreen(ride: ride),
                      ),
                    );
                  },
                  child: _RideCard(ride: ride),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  const _RideCard({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.backgroundBeige,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FullName(ride: ride),
                _Rating(),
              ],
            ),
            const SizedBox(height: 8),
            _Age(ride: ride),
            const SizedBox(height: 12),
            _Date(ride: ride),
            const SizedBox(height: 8),
            _FromToCities(ride: ride),
            const SizedBox(height: 12),
            _FromAddress(ride: ride),
            const SizedBox(height: 4),
            _ToAddress(ride: ride),
            const SizedBox(height: 12),
            _SeatsAndCost(ride: ride),
          ],
        ),
      ),
    );
  }
}

class _SeatsAndCost extends StatelessWidget {
  const _SeatsAndCost({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Available seats: ${ride.seats}',
              style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
            ),
          ],
        ),
        Text(
          'Cost: ${ride.cost} r.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
      ],
    );
  }
}

class _ToAddress extends StatelessWidget {
  const _ToAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          'To: ${ride.address2}',
          style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
        ),
      ],
    );
  }
}

class _FromAddress extends StatelessWidget {
  const _FromAddress({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          'from: ${ride.address1}',
          style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
        ),
      ],
    );
  }
}

class _FromToCities extends StatelessWidget {
  const _FromToCities({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${ride.from} - ${ride.to}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${ride.date.day}.${ride.date.month}.${ride.date.year} - ${ride.date.hour}:${ride.date.min}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
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
    return Text(
      '${ride.age} years old',
      style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
    );
  }
}

class _Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          '5.0',
          style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
        ),
      ],
    );
  }
}

class _FullName extends StatelessWidget {
  const _FullName({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      ride.fullName,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryGreen,
      ),
    );
  }
}
