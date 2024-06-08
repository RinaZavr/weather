import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:weather/domain/services/location_service.dart';
import 'package:weather/domain/services/network_service.dart';
import 'package:weather/domain/services/repository_sp.dart';
import 'package:weather/ui/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingleton<NetworkService>(NetworkService());
  LocationService locationService = LocationService();
  await locationService.getCurrentLocation();
  GetIt.I.registerSingleton<LocationData>(await locationService.getCurrentLocation());
  RepositorySP prefs = RepositorySP();
  await prefs.init();
  GetIt.I.registerSingleton<RepositorySP>(prefs);
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
