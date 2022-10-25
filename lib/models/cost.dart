import 'cost_item.dart';

class Cost {
  final int id;
  final double total;
  final List<CostItem> costItems;

  Cost({
    required this.id,
    required this.total,
    required this.costItems,
  });

  factory Cost.fromJson(Map<String, dynamic> json) {
    return Cost(
      id: json['id'] as int,
      total: double.parse(json['total'] ?? '0.0'),
      costItems: List<CostItem>.from(json['cost_items'].map((costItem) => CostItem.fromJson(costItem))),
    );
  }
}
