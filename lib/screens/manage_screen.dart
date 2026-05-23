import 'package:flutter/material.dart';

import '../models/travel_item.dart';
import '../services/demo_repository.dart';
import '../theme.dart';
import '../widgets/background_header.dart';
import '../widgets/item_tile.dart';
import '../widgets/responsive_shell.dart';
import '../widgets/section_panel.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  static const routeName = '/manage';

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = DemoRepository.allItems
        .where((item) => item.name.toLowerCase().contains(_query.toLowerCase()) || item.bag.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return ResponsiveShell(
      currentRoute: ManageScreen.routeName,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        onPressed: _showAddItemSheet,
        child: const Icon(Icons.add_rounded),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'Manage barang',
              subtitle: 'Urus senarai, kategori, dan lokasi simpanan item travel anda.',
              compact: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) => setState(() => _query = value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search_rounded),
                          hintText: 'Cari item atau beg',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SectionPanel(
                        title: 'Senarai Item',
                        child: Column(
                          children: items.map((item) {
                            return ItemTile(
                              item: item,
                              trailing: _StatusChip(status: item.status),
                            );
                          }).toList(),
                        ),
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

  void _showAddItemSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tambah item', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Nama item', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: 'Lokasi beg', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final PackingStatus status;

  @override
  Widget build(BuildContext context) {
    final text = switch (status) {
      PackingStatus.packed => 'Packed',
      PackingStatus.missing => 'Missing',
      PackingStatus.optional => 'Optional',
    };
    final color = switch (status) {
      PackingStatus.packed => AppColors.green,
      PackingStatus.missing => Colors.orange,
      PackingStatus.optional => Colors.blueGrey,
    };

    return Chip(
      label: Text(text),
      backgroundColor: color.withOpacity(.12),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w800),
      side: BorderSide.none,
    );
  }
}
