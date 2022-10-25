import 'package:lakuseni_user/models/address.dart';

import 'city.dart';
import 'user.dart';

class Seller {
  final int id;
  final User user;
  final Address address;

  Seller({
    required this.id,
    required this.user,
    required this.address,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
        id: json['id'] as int,
        user: User.fromJson(json['user']),
        address: Address.fromJson(json['address']),
        );
  }

}