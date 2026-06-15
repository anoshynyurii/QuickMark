import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickmark/core/theme/theme.dart';
import 'package:quickmark/main.dart';

class HomePage extends StatefulWidget {
  const HomePage( {
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: AppColors.info,
          child: TextButton(
            onPressed: () {
              context.push('/reader');
            },
            child: Text(Provider.of<Temp>(context).temp.toString()),
          )
          ),
        ),
    );
  }
}
