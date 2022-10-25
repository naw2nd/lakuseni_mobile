class CostItem {
  final int id;
  final String name;
  final String desc;
  final double price;

  CostItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
  });

  factory CostItem.fromJson(Map<String, dynamic> json) {
    return CostItem(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] ?? 'Tidak ada deskirpsi' as String,
      price: double.parse(json['price']) as double,
    );
  }
}
