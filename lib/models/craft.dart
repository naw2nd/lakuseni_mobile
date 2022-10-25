import 'package:lakuseni_user/models/product_image.dart';

class Craft {
  // "price": "190000.000",
  // "weight": "1700.00",

  final int id;
  final String productName;
  final int productId;
  final String productDesc;
  final int productSold;
  final double productRating;
  final double price;
  final double weight;
  final int sellerId;
  final String sellerName;
  final String sellerPhone;
  final String sellerLocation;
  final String sellerProfilePictureUrl;
  final int productCategoryId;
  final String productCategoryName;
  final List<ProductImage> productImages;

  Craft({
    required this.id,
    required this.productName,
    required this.productId,
    required this.productDesc,
    required this.productSold,
    required this.productRating,
    required this.price,
    required this.weight,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerLocation,
    required this.sellerProfilePictureUrl,
    required this.productCategoryId,
    required this.productCategoryName,
    required this.productImages,
  });

  factory Craft.fromJson(Map<String, dynamic> json) {
    return Craft(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      productId: json['product_id'] as int,
      productDesc: json['product_desc'] as String,
      productSold: json['product_sold'] as int,
      productRating: double.parse(json['product_rating'] ?? "-1.0") as double,
      price: double.parse(json['price']) as double,
      weight: double.parse(json['weight']) as double,
      sellerId: json['seller_id'] as int,
      sellerName: json['seller_name'] as String,
      sellerPhone: json['seller_phone'] as String,
      sellerLocation: json['seller_location'] as String,
      sellerProfilePictureUrl:
          json['seller_profile_picture_url'] ?? '' as String,
      productCategoryId: json['product_category_id'] as int,
      productCategoryName: json['product_category_name'] as String,
      productImages: List<ProductImage>.from(json['product_images']
          .map((productImage) => ProductImage.fromJson(productImage))),
    );
  }

  // @override
  // String toString() {
  //   return 'Craft{id: $id, product_name: $productName, product_desc: $productDesc, sold: $sold, rating: $rating}';
  // }
}
