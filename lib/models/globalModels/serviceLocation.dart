class ServiceLocation {
  ServiceLocation(
      {this.longitude = 0.0,
      this.latitude = 0.0,
      this.name = "Location Not Found"});
  String name;
  double longitude;
  double latitude;

  factory ServiceLocation.fromJson(Map<String, dynamic> json) =>
      ServiceLocation(
          longitude:
              json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
          latitude: json["latitude"].toDouble(),
          name: json["name"] ?? "Location Not Found");

  Map<String, dynamic> toJson() =>
      {"longitude": longitude, "latitude": latitude, "name": name};
}
