import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../theme.dart';
import '../widgets/background_header.dart';
import '../widgets/responsive_shell.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      currentRoute: routeName,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'About JustSnap',
              subtitle: 'Pembantu travel pintar yang menjadikan semakan barang lebih pantas, jelas, dan yakin.',
              compact: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth > 760;
                      final cards = [
                        const _AboutCard(image: AppAssets.aboutOne, title: 'Snap', body: 'Imbas objek menggunakan kamera dan kenal pasti barang penting.'),
                        const _AboutCard(image: AppAssets.aboutTwo, title: 'Manage', body: 'Susun item mengikut beg, kategori, dan status semakan.'),
                        const _AboutCard(image: AppAssets.aboutThree, title: 'Alert', body: 'Terima peringatan jika barang wajib belum diimbas.'),
                      ];
                      return GridView.count(
                        crossAxisCount: wide ? 3 : 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: wide ? .84 : 1.28,
                        children: cards,
                      );
                    },
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

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.image, required this.title, required this.body});

  final String image;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.green)),
                const SizedBox(height: 8),
                Text(body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
