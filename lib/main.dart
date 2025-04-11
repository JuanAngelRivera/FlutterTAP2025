import 'package:flutter/material.dart';
import 'package:flutter_application/screens/challenge_screen.dart';
import 'package:flutter_application/screens/login_screen.dart';
import 'package:flutter_application/screens/dashboard_screen.dart';
import 'package:flutter_application/utils/global_values.dart';
import 'package:flutter_application/utils/theme_settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, value, Widget) {
        return MaterialApp(
          title: 'Material App',
          home: const LoginScreen(),
          routes: {
            "/dash": (context) => const DashboardScreen(),
            "/challenge": (context) => ChallengeScreen(),
          },
          theme: ThemeSettings.setTheme(value),
        );
      },
    );
  }
}
