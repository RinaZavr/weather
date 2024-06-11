import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/ui/settings/widgets/appearance_widget.dart';
import 'package:weather/ui/settings/widgets/units_widget.dart';
import 'package:weather/utils/consts/string_consts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppStrings.buttonDone,
              style: ThemeProvider.controllerOf(context)
                  .theme
                  .data
                  .textTheme
                  .displaySmall,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                AppStrings.titleSettings,
                style: ThemeProvider.controllerOf(context)
                    .theme
                    .data
                    .textTheme
                    .titleLarge,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: UnitsWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            const SliverToBoxAdapter(
              child: AppearanceWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
