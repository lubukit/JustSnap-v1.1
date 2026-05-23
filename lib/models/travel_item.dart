enum PackingStatus { packed, missing, optional }

class TravelItem {
  const TravelItem({
    required this.id,
    required this.name,
    required this.category,
    required this.bag,
    required this.status,
    required this.confidence,
  });

  final String id;
  final String name;
  final String category;
  final String bag;
  final PackingStatus status;
  final double confidence;

  TravelItem copyWith({
    String? id,
    String? name,
    String? category,
    String? bag,
    PackingStatus? status,
    double? confidence,
  }) {
    return TravelItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      bag: bag ?? this.bag,
      status: status ?? this.status,
      confidence: confidence ?? this.confidence,
    );
  }
}
