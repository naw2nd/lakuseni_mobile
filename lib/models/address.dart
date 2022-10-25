import 'city.dart';

class Address {
  final int id;
  final String desc;
  final String url;
  final City city;

  Address({
    required this.id,
    required this.desc,
    required this.url,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      desc: json['desc'] as String,
      url: json['url'] as String,
      city: City.fromJson(json['city']),
    );
  }
}
