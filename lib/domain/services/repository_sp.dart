import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/models/location_model.dart';

class RepositorySP {
  SharedPreferences? prefs;
  String key = 'locations';

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void addLocation(Location location) {
    var locations = prefs?.getStringList(key);
    if (locations == null || locations.isEmpty) {
      prefs?.setStringList(key, [jsonEncode(location.toJson())]);
    } else {
      locations.add(jsonEncode(location.toJson()));
      prefs?.setStringList(key, locations);
    }
  }

  void removeLocation(Location location) {
    var locations = prefs?.getStringList(key);
    if (locations == null || locations.isEmpty) {
      return;
    } else {
      locations.remove(jsonEncode(location.toJson()));
      prefs?.setStringList(key, locations);
    }
  }

  List<Location> getLocations() {
    var locations = prefs?.getStringList(key);
    if (locations == null || locations.isEmpty) {
      return [];
    } else {
      return locations
          .map((e) => Location.fromJson(jsonDecode(e)))
          .toList();
    }
  }
}