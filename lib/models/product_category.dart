class ProductCategory {
  // "id": 1,
  // "name": "Lukis",
  // "desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam dolor libero, sagittis at semper vel, commodo et quam. In rutrum ante nunc, ut venenatis risus placerat nec.",
  // "product_type": "craft",
  final int id;
  final String name;
  final String desc;
  final String product_type;

  ProductCategory({
    required this.id,
    required this.name,
    required this.desc,
    required this.product_type,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] ?? 'Tidak ada deskirpsi' as String,
      product_type: json['product_type'] as String,
    );
  }

  // @override
  // String toString() {
  //   return 'SellerType{id: $id, name: $name, desc: $desc}';
  // }
}
