import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/models/location_model.dart';
import 'package:weather/domain/services/location_service.dart';

class RepositorySP {
  SharedPreferences? prefs;
  String keyLocation = 'locations';
  String keyLocationUnit = 'units';
  List<String> units = ['C, Km, KPH', 'F, M, MPH'];
  String currentUnit = '';

  init() async {
    prefs = await SharedPreferences.getInstance();
    currentUnit = getUnit();
  }

  void addLocation(LocationInfo location) {
    var locations = prefs?.getStringList(keyLocation);
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      prefs?.setStringList(keyLocation, [loc]);
    } else if (!locations.contains(loc) &&
        location.lat !=
            ((GetIt.I<LocationService>().currentLocation.latitude ?? 0) * 10)
                    .round() /
                10 &&
        location.lon !=
            ((GetIt.I<LocationService>().currentLocation.longitude ?? 0) * 10)
                    .round() /
                10) {
      locations.add(loc);
      prefs?.setStringList(keyLocation, locations);
    }
  }

  void removeLocation(LocationInfo location) {
    var locations = prefs?.getStringList(keyLocation);
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      return;
    } else if (locations.contains(loc)) {
      locations.remove(loc);
      prefs?.setStringList(keyLocation, locations);
    }
  }

  List<LocationInfo> getLocations() {
    var locations = prefs?.getStringList(keyLocation);
    if (locations == null || locations.isEmpty) {
      return [];
    }
    return locations.map((e) => LocationInfo.fromJson(jsonDecode(e))).toList();
  }

  void setLocations(List<LocationInfo> locations) {
    prefs?.setStringList(
        keyLocation, locations.map((e) => jsonEncode(e.toJson())).toList());
  }

  String getUnit() {
    return prefs?.getString(keyLocationUnit) ?? 'C, Km, Km/H';
  }

  void setUnit(String unit) {
    currentUnit = unit;
    prefs?.setString(keyLocationUnit, unit);
  }
}
