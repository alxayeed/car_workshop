import 'package:car_workshop/features/auth/presentation/screens/register_screen.dart';
import 'package:car_workshop/features/bookings/presentation/screens/add_booking_screen.dart';
import 'package:car_workshop/features/bookings/presentation/screens/bookig_list_screen.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String bookings = '/bookings';
  static const String addBooking = '/addBooking';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: bookings, page: () => BookingsListScreen()),
    GetPage(name: addBooking, page: () => AddBookingScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
  ];
}
