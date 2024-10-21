import 'package:car_workshop/features/bookings/presentation/screens/bookig_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.appTitle),
      ),
      body: BookingsListScreen(),
    );
  }
}
