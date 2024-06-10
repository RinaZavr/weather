import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/models/location_model.dart';

class RepositorySP {
  SharedPreferences? prefs;
  String key = 'locations';

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void addLocation(LocationInfo location) {
    var locations = prefs?.getStringList(key);
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      prefs?.setStringList(key, [loc]);
    } else if (!locations.contains(loc) &&
        location.lat != ((GetIt.instance<LocationData>().latitude ?? 0) * 10).round() / 10 &&
        location.lon != ((GetIt.instance<LocationData>().longitude  ?? 0) * 10).round() / 10) {
      locations.add(loc);
      prefs?.setStringList(key, locations);
    }
  }

  void removeLocation(LocationInfo location) {
    var locations = prefs?.getStringList(key);
    String loc = jsonEncode(location.toJson());
    if (locations == null || locations.isEmpty) {
      return;
    } else if (locations.contains(loc)) {
      locations.remove(loc);
      prefs?.setStringList(key, locations);
    }
  }

  List<LocationInfo> getLocations() {
    var locations = prefs?.getStringList(key);
    if (locations == null || locations.isEmpty) {
      return [];
    }
    return locations.map((e) => LocationInfo.fromJson(jsonDecode(e))).toList();
  }

  void setLocations(List<LocationInfo> locations) {
    prefs?.setStringList(
        key, locations.map((e) => jsonEncode(e.toJson())).toList());

    // return locations
    //     .map((e) => Location.fromJson(jsonDecode(e)))
    //     .toList();
    // }
  }
}
