import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../screens/about_screen.dart';
import '../screens/alerts_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/manage_screen.dart';
import '../screens/snap_screen.dart';
import '../theme.dart';

class ResponsiveShell extends StatelessWidget {
  const ResponsiveShell({
    super.key,
    required this.currentRoute,
    required this.child,
    this.floatingActionButton,
  });

  final String currentRoute;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;
        return Scaffold(
          floatingActionButton: floatingActionButton,
          body: Row(
            children: [
              if (isWide) _SideNav(currentRoute: currentRoute),
              Expanded(child: child),
            ],
          ),
          bottomNavigationBar: isWide ? null : _BottomNav(currentRoute: currentRoute),
        );
      },
    );
  }
}

class _SideNav extends StatelessWidget {
  const _SideNav({required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 244,
      color: AppColors.deepGreen,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssets.logoWhite, width: 118, errorBuilder: (_, __, ___) => const SizedBox()),
          const SizedBox(height: 36),
          ..._destinations.map(
            (destination) => _NavTile(
              destination: destination,
              selected: currentRoute == destination.route,
              expanded: true,
            ),
          ),
          const Spacer(),
          Text(
            'AI Travel Packing',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Semak barang penting sebelum bergerak.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _mobileDestinations.indexWhere((item) => item.route == currentRoute);
    return NavigationBar(
      height: 72,
      selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
      onDestinationSelected: (index) => _open(context, _mobileDestinations[index].route),
      destinations: _mobileDestinations
          .map(
            (destination) => NavigationDestination(
              icon: Image.asset(destination.icon, width: 24, height: 24, errorBuilder: (_, __, ___) => Icon(destination.fallbackIcon)),
              selectedIcon: Image.asset(destination.icon, width: 28, height: 28, errorBuilder: (_, __, ___) => Icon(destination.fallbackIcon)),
              label: destination.label,
            ),
          )
          .toList(),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.destination,
    required this.selected,
    required this.expanded,
  });

  final _Destination destination;
  final bool selected;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _open(context, destination.route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Image.asset(
                  destination.icon,
                  width: 24,
                  height: 24,
                  errorBuilder: (_, __, ___) => Icon(destination.fallbackIcon, color: selected ? AppColors.green : Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  destination.label,
                  style: TextStyle(
                    color: selected ? AppColors.green : Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _open(BuildContext context, String route) {
  if (ModalRoute.of(context)?.settings.name == route) return;
  Navigator.of(context).pushReplacementNamed(route);
}

const _destinations = [
  _Destination('Home', HomeScreen.routeName, AppAssets.logoWhite, Icons.home_rounded),
  _Destination('Snap', SnapScreen.routeName, AppAssets.snapIcon, Icons.camera_alt_rounded),
  _Destination('Alert', AlertsScreen.routeName, AppAssets.alertIcon, Icons.notifications_active_rounded),
  _Destination('History', HistoryScreen.routeName, AppAssets.historyIcon, Icons.history_rounded),
  _Destination('Manage', ManageScreen.routeName, AppAssets.manageIcon, Icons.inventory_2_rounded),
  _Destination('About', AboutScreen.routeName, AppAssets.aboutIcon, Icons.info_rounded),
];

const _mobileDestinations = [
  _Destination('Home', HomeScreen.routeName, AppAssets.logoGreen, Icons.home_rounded),
  _Destination('Snap', SnapScreen.routeName, AppAssets.snapIcon, Icons.camera_alt_rounded),
  _Destination('Alert', AlertsScreen.routeName, AppAssets.alertIcon, Icons.notifications_active_rounded),
  _Destination('History', HistoryScreen.routeName, AppAssets.historyIcon, Icons.history_rounded),
  _Destination('Manage', ManageScreen.routeName, AppAssets.manageIcon, Icons.inventory_2_rounded),
];

class _Destination {
  const _Destination(this.label, this.route, this.icon, this.fallbackIcon);

  final String label;
  final String route;
  final String icon;
  final IconData fallbackIcon;
}
