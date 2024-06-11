import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/ui/location/cubit/search_cubit.dart';
import 'package:weather/ui/location/widgets/list_locations_widget.dart';
import 'package:weather/ui/location/widgets/search_widget.dart';
import 'package:weather/utils/consts/string_consts.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isEdit = false;
  bool canEdit = true;
  SearchCubit searchCubit = SearchCubit();

  @override
  void dispose() {
    searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: canEdit
            ? Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                  child: Text(
                    isEdit ? AppStrings.buttonDone : AppStrings.buttonEdit,
                    style: ThemeProvider.controllerOf(context)
                        .theme
                        .data
                        .textTheme
                        .displaySmall,
                  ),
                ),
            )
            : null,
        actions: [
          if (!isEdit)
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
                AppStrings.titleLocations,
                style: ThemeProvider.controllerOf(context)
                    .theme
                    .data
                    .textTheme
                    .titleLarge,
              ),
            ),
            SliverToBoxAdapter(
              child: BlocProvider(
                create: (context) => searchCubit,
                child: Column(
                  children: [
                    SearchWidget(
                        searchCubit: searchCubit,
                        canEdit: (value) => canEdit = value),
                    ListLocationsWidget(
                      isEdit: isEdit,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
