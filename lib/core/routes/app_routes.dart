import 'package:go_router/go_router.dart';
import 'package:quickmark/core/routes/navigation_shell.dart';
import 'package:quickmark/presentation/pages/home_page.dart';
import 'package:quickmark/presentation/pages/reader_page.dart';
import 'package:quickmark/presentation/pages/settings_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationShell(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reader',
              builder: (context, state) => ReaderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
