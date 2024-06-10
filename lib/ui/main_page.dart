import 'package:flutter/material.dart';
import 'package:weather/ui/forecast/screens/forecast_screen.dart';
import 'package:weather/ui/location/screens/location_screen.dart';
import 'package:weather/ui/settings/screens/settings_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForecastScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart_outlined,
            ),
            label: 'Forecast',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    if(index == 0) {
      showModalBottomSheet(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
          isScrollControlled: true,
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (context) => const LocationScreen(),
        );
    } else if(index == 2) {
      showModalBottomSheet(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
          isScrollControlled: true,
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (context) => const SettingScreen(),
        );
    }
  }
}
