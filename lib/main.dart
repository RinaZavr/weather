import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/services/network_service.dart';
import 'package:weather/ui/main_page.dart';

void main() {
  GetIt.instance.registerSingleton<NetworkService>(NetworkService());
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
