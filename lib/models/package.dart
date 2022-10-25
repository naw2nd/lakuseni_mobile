class Package {


  final int id;
  final String name;
  final int performanceId;
  final double price;
  final String desc;
  final String imageUrl;
  final String packageType;

  Package({
    required this.id,
    required this.name,
    required this.performanceId,
    required this.price,
    required this.desc,
    required this.imageUrl,
    required this.packageType,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as int,
      name: json['name'] as String,
      performanceId: json['performance_id'] as int,
      price: double.parse(json['price']) as double,
      desc: json['desc'] ?? 'Tidak ada deskirpsi' as String,
      imageUrl: json['image_url'] ?? '',
      packageType: json['package_type'] as String,
    );
  }
}
