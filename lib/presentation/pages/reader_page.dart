import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickmark/core/theme/theme.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: AppColors.warning,
          child: TextButton(
            onPressed: () {
              context.push(
                '/settings',
              );
            },
            child: Text(Provider.of<List<String>>(context).last),
          ),
        ),
      ),
    );
  }
}
