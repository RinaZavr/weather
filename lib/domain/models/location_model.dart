class LocationInfo {
  final String name;
  final String country;
  final String region;
  final double lat;
  final double lon;
  LocationInfo(
      {required this.name,
      required this.country,
      required this.region,
      required this.lat,
      required this.lon});

  LocationInfo.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        country = json['country'],
        region = json['region'],
        lat = json['lat'],
        lon = json['lon'];
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'region': region,
    'lat': lat,
    'lon': lon
  };
}