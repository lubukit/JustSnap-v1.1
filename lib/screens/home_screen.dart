import 'package:flutter/material.dart';

import '../models/travel_item.dart';
import '../services/demo_repository.dart';
import '../theme.dart';
import '../widgets/background_header.dart';
import '../widgets/item_tile.dart';
import '../widgets/responsive_shell.dart';
import '../widgets/section_panel.dart';
import '../widgets/stat_card.dart';
import 'alerts_screen.dart';
import 'snap_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final items = DemoRepository.allItems;
    final packed = items.where((item) => item.status == PackingStatus.packed).length;
    final missing = items.where((item) => item.status == PackingStatus.missing).length;

    return ResponsiveShell(
      currentRoute: routeName,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'JustSnap',
              subtitle: 'Imbas, kenal pasti, dan semak barang bawaan travel anda sebelum bertolak.',
              actions: [
                PrimaryPillButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Mula Snap',
                  onPressed: () => Navigator.pushReplacementNamed(context, SnapScreen.routeName),
                ),
                PrimaryPillButton(
                  icon: Icons.notifications_active_rounded,
                  label: 'Semak Alert',
                  onPressed: () => Navigator.pushReplacementNamed(context, AlertsScreen.routeName),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final wide = constraints.maxWidth > 760;
                          return GridView.count(
                            crossAxisCount: wide ? 3 : 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: wide ? 2.6 : 3.4,
                            children: [
                              StatCard(label: 'Barang disimpan', value: '$packed', icon: Icons.check_circle_rounded, color: AppColors.green),
                              StatCard(label: 'Belum diimbas', value: '$missing', icon: Icons.warning_rounded, color: Colors.orange),
                              StatCard(label: 'Beg aktif', value: '${DemoRepository.bags.length}', icon: Icons.backpack_rounded, color: Colors.blueGrey),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final wide = constraints.maxWidth > 860;
                          final recentPanel = SectionPanel(
                                  title: 'Recent Add',
                                  child: Column(
                                    children: items
                                        .where((item) => item.status == PackingStatus.packed)
                                        .map((item) => ItemTile(item: item))
                                        .toList(),
                                  ),
                                );
                          final bagPanel = SectionPanel(
                                  title: 'Beg Travel',
                                  child: Column(
                                    children: DemoRepository.bags.map((bag) {
                                      return ListTile(
                                        leading: Image.asset(bag.icon, width: 36, height: 36, errorBuilder: (_, __, ___) => const Icon(Icons.backpack_rounded)),
                                        title: Text(bag.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                                        subtitle: Text('${bag.packedCount} lengkap, ${bag.missingCount} belum diimbas'),
                                        trailing: const Icon(Icons.chevron_right_rounded),
                                      );
                                    }).toList(),
                                  ),
                                );
                          if (!wide) {
                            return Column(
                              children: [
                                recentPanel,
                                const SizedBox(height: 18),
                                bagPanel,
                              ],
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: recentPanel),
                              const SizedBox(width: 18),
                              Expanded(flex: 2, child: bagPanel),
                            ],
                          );
                        },
                      ),
                    ],
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
