class Payment {
  final int id;
  final int orderId;
  final String imageUrl;

  Payment({
    required this.id,
    required this.orderId,
    required this.imageUrl,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      imageUrl: json['image_url'] ?? '',
    );
  }
}
