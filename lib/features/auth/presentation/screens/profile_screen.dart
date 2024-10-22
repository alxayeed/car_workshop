import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user == null
          ? const Center(child: Text('No user data available.'))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailText('Name', user.name, FontAwesomeIcons.user),
                    const Divider(thickness: 1),
                    _buildDetailText(
                        'Email', user.email, FontAwesomeIcons.envelope),
                    const Divider(thickness: 1),
                    _buildDetailText(
                        'Role', user.role.name, FontAwesomeIcons.solidUser),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        authService.clearCurrentUser();
                        Get.offAllNamed('/login');
                      },
                      child: const Text('Logout'),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailText(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          FaIcon(icon, color: Colors.grey[700]),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
