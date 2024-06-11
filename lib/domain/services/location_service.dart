import 'package:location/location.dart';

class LocationService {
  LocationData locationData = LocationData.fromMap({});
  Location location = Location();

  LocationData get currentLocation => locationData;

  set currentLocation(LocationData location) => locationData = location;

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return LocationData.fromMap(
            {'latitude': 55.0373056, 'longitude': 73.2672704});
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return LocationData.fromMap(
            {'latitude': 55.0373056, 'longitude': 73.2672704});
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }
}
