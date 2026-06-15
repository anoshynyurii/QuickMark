import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickmark/core/theme/theme.dart';
import 'package:quickmark/main.dart';
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
        title: Platform.isAndroid ? null : const DesktopTitleBar(),
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

class DesktopTitleBar extends StatefulWidget {
  const DesktopTitleBar({super.key});

  @override
  State<DesktopTitleBar> createState() => _DesktopTitleBarState();
}

class _DesktopTitleBarState extends State<DesktopTitleBar> {
  bool isMaximized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    isMaximized = await windowManager.isMaximized();
    setState(() {});
  }

  Future<void> _toggleMaximize() async {
    if (await windowManager.isMaximized()) {
      await windowManager.restore();
      isMaximized = false;
    } else {
      await windowManager.maximize();
      isMaximized = true;
    }
    setState(() {});
  }

  void _switchTheme() {
    context.read<ThemeNotif>().switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotif = context.watch<ThemeNotif>();
    return DragToMoveArea(
      child: Container(
        height: 28,
        color: AppColors.darkPrimary,
        child: Row(
          children: [
            const Spacer(),

            _TitleBarButton(
              icon: themeNotif.themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode,
              onTap: _switchTheme,
            ),

            _TitleBarButton(
              icon: Icons.remove,
              onTap: () => windowManager.minimize(),
            ),

            _TitleBarButton(
              icon: isMaximized
                  ? Icons.crop_square
                  : Icons.check_box_outline_blank,
              onTap: _toggleMaximize,
            ),

            _TitleBarButton(
              icon: Icons.close,
              hoverColor: AppColors.error,
              onTap: () => windowManager.close(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleBarButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? hoverColor;

  const _TitleBarButton({
    required this.icon,
    required this.onTap,
    this.hoverColor,
  });

  @override
  State<_TitleBarButton> createState() => _TitleBarButtonState();
}

class _TitleBarButtonState extends State<_TitleBarButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final hover =
        widget.hoverColor ?? AppColors.darkTextSecondary.withAlpha(150);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Container(
          width: 46,
          height: double.infinity,
          color: isHovering ? hover : Colors.transparent,
          child: Icon(
            widget.icon,
            size: 16,
            color: AppColors.darkTextPrimary,
          ),
        ),
      ),
    );
  }
}
