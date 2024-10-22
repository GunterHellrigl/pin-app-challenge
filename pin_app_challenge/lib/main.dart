import 'package:flutter/material.dart';
import 'package:pin_app_challenge/di.dart';
import 'package:pin_app_challenge/router/router.dart';

void main() {
  setupDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pin App Challenge',
      routerConfig: router,
    );
  }
}
