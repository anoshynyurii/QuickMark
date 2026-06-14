import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmark/core/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: AppColors.error,
      ),
      )
    );
  }
}
