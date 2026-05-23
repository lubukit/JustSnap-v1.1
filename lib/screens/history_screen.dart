import 'package:flutter/material.dart';

import '../services/demo_repository.dart';
import '../widgets/background_header.dart';
import '../widgets/item_tile.dart';
import '../widgets/responsive_shell.dart';
import '../widgets/section_panel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final items = DemoRepository.allItems.reversed.toList();

    return ResponsiveShell(
      currentRoute: routeName,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'History',
              subtitle: 'Jejak imbasan dan perubahan barang bawaan anda.',
              compact: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: SectionPanel(
                    title: 'Aktiviti Terkini',
                    child: Column(
                      children: [
                        for (final item in items)
                          ItemTile(
                            item: item,
                            trailing: const Icon(Icons.chevron_right_rounded),
                          ),
                      ],
                    ),
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
