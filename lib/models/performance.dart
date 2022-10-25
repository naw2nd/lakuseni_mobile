import 'dart:convert';
import 'package.dart';
import 'product_image.dart';

class Performance {
  // "price": "190000.000",
  // "weight": "1700.00",

  final int id;
  final int productId;

  final String productName;
  final String productDesc;
  final int productSold;
  final double productRating;
  final double price;
  final int sellerId;
  final String sellerName;
  final String sellerLocation;
  final String sellerProfilePictureUrl;
  final int productCategoryId;
  final String productCategoryName;
  final List<Package> packages;
  final List<ProductImage> productImages;

  Performance({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.productSold,
    required this.productRating,
    required this.price,
    required this.sellerId,
    required this.sellerName,
    required this.sellerLocation,
    required this.sellerProfilePictureUrl,
    required this.productCategoryId,
    required this.productCategoryName,
    required this.packages,
    required this.productImages,
  });

  factory Performance.fromJson(Map<String, dynamic> json) {

    return Performance(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      productDesc: json['product_desc'] as String,
      productSold: json['product_sold'] as int,
      productRating: double.parse(json['product_rating'] ?? "-1.0") as double,
      price: double.parse(json['price']) as double,
      sellerId: json['seller_id'] as int,
      sellerName: json['seller_name'] as String,
      sellerLocation: json['seller_location'] as String,
      sellerProfilePictureUrl:
          json['seller_profile_picture_url'] ?? '' as String,
      productCategoryId: json['product_category_id'] as int,
      productCategoryName: json['product_category_name'] as String,
      packages: List<Package>.from(
        json['packages'].map((package) => Package.fromJson(package))),
      productImages: List<ProductImage>.from(json['product_images']
          .map((productImage) => ProductImage.fromJson(productImage))),
    );
  }

  // @override
  // String toString() {
  //   return 'Craft{id: $id, product_name: $productName, product_desc: $productDesc, sold: $sold, rating: $rating}';
  // }
}
