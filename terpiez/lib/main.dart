import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:terpiez/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const TerpiezApp());
}

class TerpiezApp extends StatelessWidget {
  const TerpiezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terpiez',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Colors.grey.shade50,
        cardTheme: const CardThemeData(
          margin: EdgeInsets.zero,
          elevation: 1,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
