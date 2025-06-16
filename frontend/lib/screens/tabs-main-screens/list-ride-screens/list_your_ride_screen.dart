import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/test_data_search_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/list-ride-screens/your_ride_details_screen.dart';

class ListRideScreen extends StatelessWidget {
  const ListRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
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
                            builder: (context) =>
                                YourRideDetailsScreen(ride: ride),
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
            _FullNameAndRating(ride: ride),
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

class _FullNameAndRating extends StatelessWidget {
  const _FullNameAndRating({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ride.fullName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '5.0',
              style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
            ),
          ],
        ),
      ],
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

class _SeatsAndCost extends StatelessWidget {
  const _SeatsAndCost({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _AvailableSeats(ride: ride),
        _Cost(ride: ride),
      ],
    );
  }
}

class _AvailableSeats extends StatelessWidget {
  const _AvailableSeats({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          'Available seats: ${ride.seats}',
          style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
        ),
      ],
    );
  }
}

class _Cost extends StatelessWidget {
  const _Cost({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cost: ${ride.cost} r.',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryGreen,
      ),
    );
  }
}
