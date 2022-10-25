class ProductImage {
  final int id;
  final int productId;
  final String imageUrl;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      imageUrl: json['image_url'] ?? '',
    );
  }
}