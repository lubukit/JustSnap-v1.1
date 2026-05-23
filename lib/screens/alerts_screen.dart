import 'package:flutter/material.dart';

import '../models/travel_item.dart';
import '../services/demo_repository.dart';
import '../theme.dart';
import '../widgets/background_header.dart';
import '../widgets/responsive_shell.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const routeName = '/alerts';

  @override
  Widget build(BuildContext context) {
    final missingItems = DemoRepository.allItems.where((item) => item.status == PackingStatus.missing).toList();

    return ResponsiveShell(
      currentRoute: routeName,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'Alert barang tertinggal',
              subtitle: 'JustSnap mengingatkan barang penting yang belum diimbas sebelum perjalanan.',
              compact: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 880),
                  child: Column(
                    children: missingItems.map((item) => _AlertCard(item: item)).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.item});

  final TravelItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              children: [
                const TextSpan(text: 'Kami perasan anda belum mengimbas '),
                TextSpan(text: item.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const TextSpan(text: '.\nAdakah anda lupa membawanya?'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.green)),
            ),
          ),
        ],
      ),
    );
  }
}
