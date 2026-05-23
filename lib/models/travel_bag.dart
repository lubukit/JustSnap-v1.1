import 'travel_item.dart';

class TravelBag {
  const TravelBag({
    required this.name,
    required this.icon,
    required this.items,
  });

  final String name;
  final String icon;
  final List<TravelItem> items;

  int get packedCount => items.where((item) => item.status == PackingStatus.packed).length;
  int get missingCount => items.where((item) => item.status == PackingStatus.missing).length;
}
