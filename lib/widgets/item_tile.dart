import 'package:flutter/material.dart';

import '../models/travel_item.dart';
import '../theme.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item, this.trailing});

  final TravelItem item;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (item.status) {
      PackingStatus.packed => AppColors.green,
      PackingStatus.missing => Colors.orange.shade700,
      PackingStatus.optional => Colors.blueGrey,
    };
    final statusText = switch (item.status) {
      PackingStatus.packed => 'Sudah diimbas',
      PackingStatus.missing => 'Belum diimbas',
      PackingStatus.optional => 'Pilihan',
    };

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CircleAvatar(
        backgroundColor: statusColor.withOpacity(.12),
        child: Icon(Icons.inventory_2_rounded, color: statusColor),
      ),
      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text('$statusText - ${item.bag}'),
      trailing: trailing ?? Text('${(item.confidence * 100).round()}%', style: TextStyle(color: statusColor, fontWeight: FontWeight.w800)),
    );
  }
}
