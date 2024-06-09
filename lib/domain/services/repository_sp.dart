import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:location/location.dart' as lib_location;
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
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      prefs?.setStringList(key, [loc]);
    } else if (!locations.contains(loc) &&
        location.lat != ((GetIt.instance<lib_location.LocationData>().latitude ?? 0) * 10).round() / 10 &&
        location.lon != ((GetIt.instance<lib_location.LocationData>().longitude  ?? 0) * 10).round() / 10) {
      locations.add(loc);
      prefs?.setStringList(key, locations);
    }
  }

  void removeLocation(Location location) {
    var locations = prefs?.getStringList(key);
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      return;
    } else if (locations.contains(loc)) {
      locations.remove(loc);
      prefs?.setStringList(key, locations);
    }
  }

  List<Location> getLocations() {
    var locations = prefs?.getStringList(key);
    if (locations == null || locations.isEmpty) {
      return [];
    }
    return locations.map((e) => Location.fromJson(jsonDecode(e))).toList();
  }

  void setLocations(List<Location> locations) {
    prefs?.setStringList(
        key, locations.map((e) => jsonEncode(e.toJson())).toList());

    // return locations
    //     .map((e) => Location.fromJson(jsonDecode(e)))
    //     .toList();
    // }
  }
}
