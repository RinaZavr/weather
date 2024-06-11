import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/services/location_service.dart';
import 'package:weather/domain/services/network_service.dart';
import 'package:weather/domain/services/repository_sp.dart';
import 'package:weather/ui/forecast/cubit/weather_cubit.dart';
import 'package:weather/ui/main_page.dart';
import 'package:weather/utils/consts/string_consts.dart';
import 'package:weather/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<NetworkService>(NetworkService());
  LocationService locationService = LocationService();
  await locationService.getCurrentLocation();
  GetIt.I.registerSingleton<LocationService>(locationService);
  RepositorySP prefs = RepositorySP();
  await prefs.init();
  GetIt.I.registerSingleton<RepositorySP>(prefs);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit()..getWeather(),
        ),
      ],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme(
            id: AppStrings.lightThemeName.toLowerCase(),
            data: LightTheme().lightTheme(),
            description: AppStrings.lightThemeName,
          ),
          AppTheme(
            id: AppStrings.darkThemeName.toLowerCase(),
            data: DarkTheme().darkTheme(),
            description: AppStrings.darkThemeName,
          ),
        ],
        child: ThemeConsumer(
          child: Builder(builder: (context) {
            return MaterialApp(
              theme: ThemeProvider.themeOf(context).data,
              debugShowCheckedModeBanner: false,
              home: const MainPage(),
            );
          }),
        ),
      ),
    );
  }
}
