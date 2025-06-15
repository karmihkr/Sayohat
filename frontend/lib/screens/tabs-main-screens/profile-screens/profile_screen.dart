import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/user_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75), // Радиус скругления
              child: Image.asset(
                'assets/images/test_ava.JPG',
                width: 146,
                height: 146,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              '${user.name} ${user.surname}',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryGreen,
                fontSize: 24,
              ),
            ),
          ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Phone:",
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          user.phone ?? " ",
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: AppColors.primaryGreen),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "Date of birth:",
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "will be soon...",
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: AppColors.primaryGreen),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'N rides were done',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 141,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundBeige,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.people,
                              color: AppColors.primaryGreen,
                              size: 30,
                            ),
                            Text(
                              'N',
                              style: const TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 24,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
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
                          color: AppColors.backgroundBeige,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.car_rental,
                              color: AppColors.primaryGreen,
                              size: 30,
                            ),
                            Text(
                              'N',
                              style: const TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 24,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
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
                  ),
                  Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(246, 46),
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
                        "Edit profile",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
