import 'province.dart';

class City {
  final int id;
  final String name;
  final int provinceId;

  City({
    required this.id,
    required this.name,
    required this.provinceId
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
      provinceId: json['province_id'] as int,
    );
  }

}