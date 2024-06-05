import 'package:flutter/material.dart';
import 'package:weather/ui/main_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // LocationService locationService = LocationService();
  // GetIt.I.registerSingleton<LocationService>(locationService);
  // locationService.getCurrentLocation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}