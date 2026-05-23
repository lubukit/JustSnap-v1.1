import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/manage_screen.dart';
import 'screens/snap_screen.dart';
import 'theme.dart';

void main() {
  runApp(const JustSnapApp());
}

class JustSnapApp extends StatelessWidget {
  const JustSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JustSnap',
      theme: buildJustSnapTheme(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        SnapScreen.routeName: (_) => const SnapScreen(),
        AlertsScreen.routeName: (_) => const AlertsScreen(),
        HistoryScreen.routeName: (_) => const HistoryScreen(),
        ManageScreen.routeName: (_) => const ManageScreen(),
        AboutScreen.routeName: (_) => const AboutScreen(),
      },
    );
  }
}
