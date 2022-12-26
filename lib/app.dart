import 'package:flutter/material.dart';
import 'package:flutter_training/views/start_up_view.dart';

class App extends StatelessWidget {
  const App({super.key});

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
