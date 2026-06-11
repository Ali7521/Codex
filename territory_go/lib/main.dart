import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_theme.dart';
import 'providers/game_state_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard.dart';
import 'screens/map_screen.dart';
import 'screens/guild_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  // Uncomment below when running with real Firebase setup
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
      ],
      child: const TerritoryGoApp(),
    ),
  );
}

class TerritoryGoApp extends StatelessWidget {
  const TerritoryGoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Territory Go',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeDashboard(),
        '/map': (context) => const MapScreen(),
        '/guild': (context) => const GuildScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/rewards': (context) => const RewardsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
