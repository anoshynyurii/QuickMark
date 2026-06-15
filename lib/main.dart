import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmark/core/routes/app_routes.dart';
import 'package:quickmark/core/theme/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(500, 500),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int a = 33;
    List<String> b = ['a', 'b', 'c'];
    return MultiProvider(
      providers: [
        Provider(create: (context) => a),
        Provider(create: (context) => b),
        ChangeNotifierProvider(create: (context) => ThemeNotif()),
        ChangeNotifierProvider(create: (context) => Temp()),
      ],
      child: Consumer<ThemeNotif>(
        builder: (context, themeNotif, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeNotif.themeMode,
          routerConfig: router,
        ),
      ),
    );
  }
}

class Temp extends ChangeNotifier {
  int temp = 20;

  void plusTemp() {
    temp++;
    notifyListeners();
  }
}

class ThemeNotif extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void switchTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
