import 'package:flutter/material.dart';
import 'package:flutter_training/views/weather_view.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({super.key});

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    // Widgetの描画が完了するまで待機
    WidgetsBinding.instance.endOfFrame;
    super.initState();
  }

  Future<void> waitAndPush() async {
    // 500ミリ秒待機
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    ).then((_) async {
      // WeatherView に遷移
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const WeatherView(),
        ),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    waitAndPush();
    return const Scaffold();
  }
}
