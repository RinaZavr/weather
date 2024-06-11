// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/location_model.dart';
import 'package:weather/domain/services/location_service.dart';
import 'package:weather/domain/services/repository_sp.dart';
import 'package:weather/ui/forecast/cubit/weather_cubit.dart';
import 'package:weather/ui/location/cubit/search_cubit.dart';
import 'package:weather/utils/consts/color_consts.dart';
import 'package:weather/utils/consts/string_consts.dart';

class ListLocationsWidget extends StatefulWidget {
  final bool isEdit;
  const ListLocationsWidget({super.key, required this.isEdit});

  @override
  State<ListLocationsWidget> createState() => _ListLocationsWidgetState();
}

class _ListLocationsWidgetState extends State<ListLocationsWidget> {
  List<LocationInfo> savedLocations = [];
  Future? dialog;

  @override
  void initState() {
    super.initState();
    savedLocations = GetIt.I<RepositorySP>().getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                GetIt.I<RepositorySP>().addLocation(state.cities[index]);
                GetIt.I<LocationService>().locationData = LocationData.fromMap(
              {'latitude': state.cities[index].lat, 'longitude': state.cities[index].lon});
                context.read<WeatherCubit>().getWeather();
                Navigator.of(context).pop();
              },
              child: Text(
                state.cities[index].name,
                style: ThemeProvider.controllerOf(context)
                    .theme
                    .data
                    .textTheme
                    .bodyMedium,
              ),
            ),
            itemCount: state.cities.length,
          );
        }
        if (state is SearchError) {
          return Text(
            state.message,
            style: ThemeProvider.controllerOf(context)
                .theme
                .data
                .textTheme
                .bodyMedium,
          );
        }
        return Column(
          children: [
            _buildCurLocation(),
            if (savedLocations.isNotEmpty)
              widget.isEdit
                  ? ReorderableListView(
                      shrinkWrap: true,
                      children: [
                        for (LocationInfo item in savedLocations)
                          _buildRowLocation(location: item),
                      ],
                      onReorder: (start, current) {
                        if (start < current) {
                          int end = current - 1;
                          LocationInfo startItem = savedLocations[start];
                          int i = 0;
                          int local = start;
                          do {
                            savedLocations[local] = savedLocations[++local];
                            i++;
                          } while (i < end - start);
                          savedLocations[end] = startItem;
                        } else if (start > current) {
                          LocationInfo startItem = savedLocations[start];
                          for (int i = start; i > current; i--) {
                            savedLocations[i] = savedLocations[i - 1];
                          }
                          savedLocations[current] = startItem;
                        }
                        GetIt.I<RepositorySP>().setLocations(savedLocations);
                        setState(() {});
                      })
                  : Column(
                      children: [
                        for (LocationInfo item in savedLocations)
                          _buildRowLocation(location: item),
                      ],
                    ),
          ],
        );
      },
    );
  }

  void _showLoading() {
    dialog = showDialog(
        context: context,
        builder: (context) {
          return const SimpleDialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            children: [Center(child: CircularProgressIndicator())],
          );
        });
  }

  void _closeLoading() {
    dialog = null;
    Navigator.of(context).pop();
  }

  Widget _buildCurLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () async {
          _showLoading();
          await GetIt.I<LocationService>().getCurrentLocation();
          _closeLoading();
          Navigator.of(context).pop();
          context.read<WeatherCubit>().getWeather();
        },
        child: Row(
          children: [
            const Icon(Icons.location_searching, color: AppColors.grey),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppStrings.titleCurrentLocation,
                style: ThemeProvider.controllerOf(context)
                    .theme
                    .data
                    .textTheme
                    .bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowLocation({
    required LocationInfo location,
    IconData? icon,
  }) {
    return Padding(
      key: Key(location.name),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          GetIt.I<LocationService>().locationData = LocationData.fromMap(
              {'latitude': location.lat, 'longitude': location.lon});
          context.read<WeatherCubit>().getWeather();
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            if (icon == null && widget.isEdit)
              IconButton(
                  onPressed: () {
                    GetIt.I<RepositorySP>().removeLocation(location);
                    savedLocations.remove(location);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete, color: Colors.red)),
            Icon(icon ?? Icons.location_on, color: AppColors.grey),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                location.name,
                style: ThemeProvider.controllerOf(context)
                    .theme
                    .data
                    .textTheme
                    .bodyMedium,
              ),
            ),
            if (icon == null && widget.isEdit)
              const Icon(Icons.list, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
