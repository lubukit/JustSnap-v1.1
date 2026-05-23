import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../theme.dart';

class BackgroundHeader extends StatelessWidget {
  const BackgroundHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 220 : 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.homeBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppAssets.logoWhite, width: 118, errorBuilder: (_, __, ___) => const SizedBox()),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontSize: compact ? 30 : 42),
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(.88)),
                ),
              ),
              if (actions != null) ...[
                const SizedBox(height: 18),
                Wrap(spacing: 12, runSpacing: 12, children: actions!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryPillButton extends StatelessWidget {
  const PrimaryPillButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.green,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}
