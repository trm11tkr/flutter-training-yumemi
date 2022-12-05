import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/utils/logger.dart';
import 'package:flutter_training/views/start_up_view.dart';

void main() {
  // Logger初期化
  Logger.configure();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartUpView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
