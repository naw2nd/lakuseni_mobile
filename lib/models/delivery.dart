class Delivery {
  final int id;
  final String courier;
  final String receipt_number;

  Delivery({
    required this.id,
    required this.courier,
    required this.receipt_number,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'] as int,
      courier: json['courier'] as String,
      receipt_number: json['receipt_number'] as String,
    );
  }

  // @override
  // String toString() {
  //   return 'Delivery{id: $id, courier: $courier, receipt_number: $receipt_number}';
  // }
}
