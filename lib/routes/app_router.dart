import 'package:go_router/go_router.dart';
import 'package:kuraimi/screens/home/home_screen.dart';
import 'package:kuraimi/screens/login_screen/login_screen.dart';
import 'package:kuraimi/screens/settings/settings.dart';
import 'package:kuraimi/screens/transactions/transactions_screen.dart';
import 'package:kuraimi/screens/services/services_screen.dart';
import 'package:kuraimi/screens/profile/profile_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
    GoRoute(path: '/transactions', builder: (context, state) => TransactionsScreen()),
    GoRoute(path: '/services', builder: (context, state) => ServicesScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
  ],
);
