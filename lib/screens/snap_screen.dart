import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../models/detection_result.dart';
import '../services/object_detection_service.dart';
import '../theme.dart';
import '../widgets/background_header.dart';
import '../widgets/responsive_shell.dart';

class SnapScreen extends StatefulWidget {
  const SnapScreen({super.key});

  static const routeName = '/snap';

  @override
  State<SnapScreen> createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {
  final ObjectDetectionService _detector = const MockObjectDetectionService();
  bool _isScanning = false;
  List<DetectionResult> _results = const [];

  Future<void> _scan() async {
    setState(() => _isScanning = true);
    final results = await _detector.detectObjects();
    if (!mounted) return;
    setState(() {
      _results = results;
      _isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      currentRoute: routeName,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BackgroundHeader(
              title: 'Snap barang anda',
              subtitle: 'Gunakan kamera untuk mengenal pasti item dan cadangkan beg simpanan secara automatik.',
              compact: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth > 760;
                      final camera = _CameraPreviewCard(isScanning: _isScanning, onScan: _scan);
                      final detections = _DetectionList(results: _results, isScanning: _isScanning);
                      if (!wide) {
                        return Column(
                          children: [
                            camera,
                            const SizedBox(height: 18),
                            detections,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: camera),
                          const SizedBox(width: 18),
                          Expanded(flex: 2, child: detections),
                        ],
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

class _CameraPreviewCard extends StatelessWidget {
  const _CameraPreviewCard({required this.isScanning, required this.onScan});

  final bool isScanning;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage(AppAssets.aboutOne),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.black.withOpacity(.16))),
            Positioned(
              left: 22,
              right: 22,
              top: 22,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const CircleAvatar(backgroundImage: AssetImage(AppAssets.aboutOne)),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Iphone 16 Pro Max', style: TextStyle(fontWeight: FontWeight.w800)),
                          Text('Stored at bag bagasi', style: TextStyle(color: AppColors.muted)),
                        ],
                      ),
                    ),
                    Icon(Icons.check_box_rounded, color: AppColors.green, size: 34),
                  ],
                ),
              ),
            ),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isScanning ? 220 : 180,
                height: isScanning ? 220 : 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(.88), width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: isScanning ? null : onScan,
                icon: isScanning
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.camera_alt_rounded),
                label: Text(isScanning ? 'Mengesan...' : 'Imbas Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetectionList extends StatelessWidget {
  const _DetectionList({required this.results, required this.isScanning});

  final List<DetectionResult> results;
  final bool isScanning;

  @override
  Widget build(BuildContext context) {
    final visibleResults = results.isEmpty
        ? const [
            DetectionResult(label: 'Passport', confidence: .92, suggestedBag: 'Beg Bagasi'),
            DetectionResult(label: 'Cable Phone', confidence: .91, suggestedBag: 'Beg sandang'),
          ]
        : results;

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AI Object Detection', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Hasil pengesanan akan muncul di sini.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted)),
          if (isScanning) ...[
            const SizedBox(height: 14),
            const LinearProgressIndicator(color: AppColors.green),
          ],
          const SizedBox(height: 16),
          ...visibleResults.map((result) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.panel, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.center_focus_strong_rounded, color: AppColors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(result.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                        Text('${result.suggestedBag} - ${(result.confidence * 100).round()}% yakin'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
