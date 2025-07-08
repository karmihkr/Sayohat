import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';
import 'package:sayohat/screens/tabs-main-screens/list-ride-screens/your_ride_details_screen.dart';
import 'package:sayohat/l10n/app_localizations.dart';

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
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (yourRides.isNotEmpty) _NonEmptyList() else _EmptyList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          loc.empty_your_rides,
          style: TextStyle(
            fontSize: 24,
            color: AppColors.primaryGreen,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}

class _NonEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: yourRides.length,
      itemBuilder: (BuildContext context, int index) {
        final ride = yourRides[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YourRideDetailsScreen(ride: ride),
              ),
            );
          },
          child: _RideCard(ride: ride),
        );
      },
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
      color: AppColors.backgroundGreen,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_FullName(ride: ride)],
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
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              loc.available_seats(ride.seats.toString()),
              style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
            ),
          ],
        ),
        Text(
          loc.cost_r(ride.cost.toString()),
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
    final loc = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          ride.address2.length > 20
              ? loc.to_address_label(ride.address2.substring(0, 20))
              : loc.to_address_label(ride.address2),
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
    final loc = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          ride.address1.length > 20
              ? loc.from_address_label(ride.address1.substring(0, 20))
              : loc.from_address_label(ride.address1),
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
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.from_to_cities(ride.from, ride.to).length > 25
          ? loc.from_to_cities(
              ride.from.substring(0, 5),
              ride.to.substring(0, 5),
            )
          : loc.from_to_cities(ride.from, ride.to),
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
      ride.date,
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
    final loc = AppLocalizations.of(context)!;
    return Text(
      loc.years_old("${ride.age}"),
      style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
    );
  }
}

class _FullName extends StatelessWidget {
  const _FullName({required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Text(
      ride.fullName.length > 20
          ? "${ride.fullName.substring(0, 21)}..."
          : ride.fullName,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryGreen,
      ),
    );
  }
}
