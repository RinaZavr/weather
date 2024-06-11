import 'package:flutter/material.dart';
import 'package:weather/ui/forecast/screens/forecast_screen.dart';
import 'package:weather/ui/location/screens/location_screen.dart';
import 'package:weather/ui/settings/screens/settings_screen.dart';
import 'package:weather/utils/consts/string_consts.dart';

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
      body: const ForecastScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            label: AppStrings.titleLocations,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart_outlined,
            ),
            label: AppStrings.titleForecast,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: AppStrings.titleSettings,
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    if (index == 0) {
      showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
        isScrollControlled: true,
        context: context,
        builder: (context) => const LocationScreen(),
      );
    } else if (index == 2) {
      showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
        isScrollControlled: true,
        context: context,
        builder: (context) => const SettingScreen(),
      );
    }
  }
}
