import 'address.dart';
import 'cost.dart';
import 'seller.dart';
import 'user.dart';
import 'package:intl/intl.dart';

class Order {
// "id": 1,
//     "desc": null,
//     "user_id": 3,
//     "seller_id": 1,
//     "product_id": 2,
//     "city_id": 59,
//     "order_status_id": 1,

  final int id;
  final String desc;
  final String orderType;
  final DateTime date;
  final User user;
  final Seller seller;
  final int productId;
  final String productName;
  final String productDesc;
  final String productCateogryName;
  final String productImageUrl;
  final Address address;
  final String orderStatusName;
  final Cost cost;

  Order({
    required this.id,
    required this.orderType,
    required this.desc,
    required this.date,
    required this.user,
    required this.seller,
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.productCateogryName,
    required this.productImageUrl,
    required this.address,
    required this.orderStatusName,
    required this.cost,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      desc: json['desc']??'' as String,
      orderType: json['order_type'] as String,
      date: DateFormat('yyyy-MM-dd').parse(json['date'] ?? '2012-12-12'),
      user: User.fromJson(json['user']),
      seller: Seller.fromJson(json['seller']),
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      productDesc: json['product_desc'] as String,
      productCateogryName: json['product_category_name'] as String,
      productImageUrl: json['product_image_url'] as String,
      address: Address.fromJson(json['address']),
      orderStatusName: json['order_status_name'] as String,
      cost: Cost.fromJson(json['cost']),
    );
  }
}
