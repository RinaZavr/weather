import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/utils/consts/color_consts.dart';
import 'package:weather/utils/consts/string_consts.dart';

class AppearanceWidget extends StatefulWidget {
  const AppearanceWidget({super.key});

  @override
  State<AppearanceWidget> createState() => _AppearanceWidgetState();
}

class _AppearanceWidgetState extends State<AppearanceWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor:
          ThemeProvider.controllerOf(context).theme.data.primaryColorDark,
      title: Text(
        AppStrings.titleSettingsTheme,
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
          CupertinoIcons.moon_fill,
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
          ThemeProvider.controllerOf(context).setTheme(value!);
        },
        value: ThemeProvider.controllerOf(context).theme.id,
        items: [
          DropdownMenuItem(
            value: AppStrings.lightThemeName.toLowerCase(),
            child: Text(
              AppStrings.lightThemeName,
              style: ThemeProvider.controllerOf(context)
                  .theme
                  .data
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.grey),
            ),
          ),
          DropdownMenuItem(
            value: AppStrings.darkThemeName.toLowerCase(),
            child: Text(
              AppStrings.darkThemeName,
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
