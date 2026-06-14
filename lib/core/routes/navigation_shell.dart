import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmark/core/theme/theme.dart';
import 'package:window_manager/window_manager.dart';

class NavigationShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationShell({super.key, required this.navigationShell});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(covariant NavigationShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_tabController.index != widget.navigationShell.currentIndex) {
      _tabController.index = widget.navigationShell.currentIndex;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      appBar: AppBar(
        toolbarHeight: Platform.isAndroid ? 0 : 28,
        titleSpacing: 0,
        title: Platform.isAndroid ? null : const DekstopTitleBar(),
        bottom: TabBar(
          tabs: const [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Reader',
            ),
            Tab(
              text: 'Settings',
            ),
          ],
          controller: _tabController,
          onTap: (index) {
            widget.navigationShell.goBranch(index, initialLocation: true);
          },
        ),
      ),
    );
  }
}

class DekstopTitleBar extends StatelessWidget {
  const DekstopTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        width: double.infinity,
        height: 28,
        color: AppColors.darkPrimary,
      ),
    );
  }
}
