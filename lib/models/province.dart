import 'city.dart';

class Province {
  final int id;
  final String name;
  final List<City> cities;

  Province({
    required this.id,
    required this.name,
    required this.cities
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'] as int,
      name: json['name'] as String,
      cities: List<City>.from(json['cities'].map((city) => City.fromJson(city))),
    );
  }

}