import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/services/repository_sp.dart';
import 'package:weather/ui/forecast/cubit/weather_cubit.dart';
import 'package:weather/utils/consts/color_consts.dart';
import 'package:weather/utils/consts/string_consts.dart';

class UnitsWidget extends StatefulWidget {
  const UnitsWidget({super.key});

  @override
  State<UnitsWidget> createState() => _UnitsWidgetState();
}

class _UnitsWidgetState extends State<UnitsWidget> {
  String curValue = '';

  @override
  void initState() {
    super.initState();
    curValue = GetIt.I<RepositorySP>().getUnit();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor:
          ThemeProvider.controllerOf(context).theme.data.primaryColorDark,
      title: Text(
        AppStrings.titleSettingsUtils,
        style: ThemeProvider.controllerOf(context)
            .theme
            .data
            .textTheme
            .titleMedium,
      ),
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.amber[800],
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          CupertinoIcons.globe,
          color: Colors.white,
        ),
      ),
      trailing: DropdownButton(
        dropdownColor:
            ThemeProvider.controllerOf(context).theme.data.primaryColorDark,
        alignment: Alignment.center,
        icon: const Icon(Icons.arrow_forward_ios_rounded,
            color: AppColors.grey, size: 15),
        underline: const SizedBox(),
        onChanged: (value) {
          setState(() {
            GetIt.I<RepositorySP>().setUnit(value.toString());
            curValue = value.toString();
            context.read<WeatherCubit>().getWeather();
          });
        },
        value: curValue,
        items: [
          DropdownMenuItem(
            value: GetIt.I<RepositorySP>().units[0],
            child: Text(
              GetIt.I<RepositorySP>().units[0],
              style: ThemeProvider.controllerOf(context)
                  .theme
                  .data
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.grey),
            ),
          ),
          DropdownMenuItem(
            value: GetIt.I<RepositorySP>().units[1],
            child: Text(
              GetIt.I<RepositorySP>().units[1],
              style: ThemeProvider.controllerOf(context)
                  .theme
                  .data
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
