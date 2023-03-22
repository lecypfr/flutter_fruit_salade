import 'package:tp_fruit/class/location.dart';

class Country {
  int id;
  String name;
  Location location;

  Country({required this.id, required this.name, required this.location});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
    );
  }
}
