import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
  List<Location> savedLocations = [];
  SearchCubit searchCubit = SearchCubit();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    savedLocations = GetIt.instance<RepositorySP>().getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 60,
        leading: TextButton(
          onPressed: () {
            setState(() {
              isEdit = !isEdit;
            });
          },
          child: Text(
            isEdit ? 'Done' : 'Edit',
            style: const TextStyle(color: AppColors.yellow),
          ),
        ),
        actions: [
          if (!isEdit)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Done',
                style: TextStyle(color: AppColors.yellow),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Text(
                'Locations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
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
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        onEditingComplete: () {
                          focusNode.unfocus();
                          if (search != '') {
                            searchCubit.search(search.trim());
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Add a location...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
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
                                GetIt.instance<RepositorySP>().addLocation(state.cities[index]);
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            itemCount: state.cities.length,
                          );
                        }
                        if (state is SearchError) {
                          return Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          );
                        }
                        return Column(
                          children: [
                            _buildRowLocation(
                                location: 'Your current location',
                                icon: Icons.location_searching),
                            if(savedLocations.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: 
                              (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: _buildRowLocation(
                                  location: savedLocations[index].name,
                                ),
                              ),
                              itemCount: savedLocations.length,
                            )
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

  Widget _buildRowLocation({required String location, IconData? icon}) {
    return Row(
      children: [
        Icon(icon ?? Icons.location_on, color: AppColors.grey),
        const SizedBox(
          width: 10,
        ),
        Text(
          location,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
