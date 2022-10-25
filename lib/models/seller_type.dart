class SellerType {
  final int id;
  final String name;
  final String desc;

  SellerType({
    required this.id,
    required this.name,
    required this.desc,
  });

  factory SellerType.fromJson(Map<String, dynamic> json) {
    return SellerType(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
    );
  }

  @override
  String toString() {
    return 'SellerType{id: $id, name: $name, desc: $desc}';
  }
}
