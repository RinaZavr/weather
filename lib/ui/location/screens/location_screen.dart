import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/location_model.dart';
import 'package:weather/domain/services/repository_sp.dart';
import 'package:weather/ui/forecast/screens/forecast_screen.dart';
import 'package:weather/ui/location/cubit/search_cubit.dart';
import 'package:weather/utils/consts/color_consts.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String search = '';
  bool isEdit = false;
  bool canEdit = true;
  List<LocationInfo> savedLocations = [];
  SearchCubit searchCubit = SearchCubit();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    savedLocations = GetIt.instance<RepositorySP>().getLocations();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 60,
        leading: canEdit
            ? TextButton(
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
                child: Text(isEdit ? 'Done' : 'Edit',
                    style: ThemeProvider.controllerOf(context)
                        .theme
                        .data
                        .textTheme
                        .displaySmall),
              )
            : null,
        actions: [
          if (!isEdit)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done',
                  style: ThemeProvider.controllerOf(context)
                      .theme
                      .data
                      .textTheme
                      .displaySmall),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Locations',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        focusNode: focusNode,
                        style: ThemeProvider.controllerOf(context)
                            .theme
                            .data
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.grey),
                        onChanged: (value) {
                          setState(() {
                            search = value;
                            if (value == '') {
                              canEdit = true;
                            }
                          });
                        },
                        onEditingComplete: () {
                          focusNode.unfocus();
                          if (search != '') {
                            canEdit = false;
                            searchCubit.search(search.trim());
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(4),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.grey,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Add a location...',
                          hintStyle: ThemeProvider.controllerOf(context)
                              .theme
                              .data
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.grey),
                          fillColor: AppColors.darkGrey,
                          filled: true,
                        ),
                      ),
                    ),
                    BlocBuilder<SearchCubit, SearchState>(
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
                                GetIt.instance<RepositorySP>()
                                    .addLocation(state.cities[index]);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForecastScreen(
                                      lat: state.cities[index].lat,
                                      lon: state.cities[index].lon,
                                    ),
                                  ),
                                );
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
                              isEdit
                                  ? ReorderableListView(
                                      shrinkWrap: true,
                                      children: [
                                        for (LocationInfo item
                                            in savedLocations)
                                          _buildRowLocation(location: item),
                                      ],
                                      onReorder: (start, current) {
                                        if (start < current) {
                                          int end = current - 1;
                                          LocationInfo startItem =
                                              savedLocations[start];
                                          int i = 0;
                                          int local = start;
                                          do {
                                            savedLocations[local] =
                                                savedLocations[++local];
                                            i++;
                                          } while (i < end - start);
                                          savedLocations[end] = startItem;
                                        } else if (start > current) {
                                          LocationInfo startItem =
                                              savedLocations[start];
                                          for (int i = start;
                                              i > current;
                                              i--) {
                                            savedLocations[i] =
                                                savedLocations[i - 1];
                                          }
                                          savedLocations[current] = startItem;
                                        }
                                        GetIt.instance<RepositorySP>()
                                            .setLocations(savedLocations);
                                        setState(() {});
                                      })
                                  : Column(
                                      children: [
                                        for (LocationInfo item
                                            in savedLocations)
                                          _buildRowLocation(location: item),
                                      ],
                                    ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop({
            'lat': GetIt.instance<LocationData>().latitude,
            'lon': GetIt.instance<LocationData>().longitude,
          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ForecastScreen(
          // lat: GetIt.instance<LocationData>().latitude,
          // lon: GetIt.instance<LocationData>().longitude,
          //     ),
          //   ),
          // );
        },
        child: Row(
          children: [
            const Icon(Icons.location_searching, color: AppColors.grey),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Your current location',
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
          Navigator.of(context).pop({
            'lat': location.lat,
            'lon': location.lon,
          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ForecastScreen(
          //       lat: location.lat,
          //       lon: location.lon,
          //     ),
          //   ),
          // );
        },
        child: Row(
          children: [
            if (icon == null && isEdit)
              IconButton(
                  onPressed: () {
                    GetIt.instance<RepositorySP>().removeLocation(location);
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
            if (icon == null && isEdit)
              const Icon(Icons.list, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
