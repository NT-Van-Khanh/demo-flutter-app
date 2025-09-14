class Location {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final DateTime localtime;

  const Location({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      localtime: DateTime.parse((json['localtime'])),
    );
  }
}
// {
//   "location": {
//     "name": "Ho Chi Minh City",
//     "region": "",
//     "country": "Vietnam",
//     "lat": 10.75,
//     "lon": 106.6667,
//     "tz_id": "Asia/Ho_Chi_Minh",
//     "localtime_epoch": 1756266133,
//     "localtime": "2025-08-27 10:42"
//   },
//   "current": {
//     "last_updated_epoch": 1756265400,
//     "last_updated": "2025-08-27 10:30",
//     "temp_c": 31.3,
//     "temp_f": 88.3,
//     "is_day": 1,
//     "condition": {
//       "text": "Partly cloudy",
//       "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
//       "code": 1003
//     },
//     "wind_mph": 10.7,
//     "wind_kph": 17.3,
//     "wind_degree": 277,
//     "wind_dir": "W",
//     "pressure_mb": 1010,
//     "pressure_in": 29.83,
//     "precip_mm": 0,
//     "precip_in": 0,  
//     "humidity": 71,
//     "cloud": 75,
//     "feelslike_c": 35,
//     "feelslike_f": 95,
//     "windchill_c": 31.2,
//     "windchill_f": 88.1,
//     "heatindex_c": 34.7,
//     "heatindex_f": 94.5,
//     "dewpoint_c": 21.6,
//     "dewpoint_f": 70.8,
//     "vis_km": 10,
//     "vis_miles": 6,
//     "uv": 5.5,
//     "gust_mph": 12.3,
//     "gust_kph": 19.9
//   }
// }