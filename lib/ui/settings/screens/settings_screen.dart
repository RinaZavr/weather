import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                ThemeProvider.controllerOf(context)
                      .setTheme('dark');
              },
              child: const Text('Dark'),
            ),
          ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                ThemeProvider.controllerOf(context)
                      .setTheme('light');
              },
              child: const Text('Light'),
            ),
          ),
        ],
      ),
    );
  }
}