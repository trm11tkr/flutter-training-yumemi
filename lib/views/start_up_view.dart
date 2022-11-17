import 'package:flutter/material.dart';
import 'package:flutter_training/views/weather_view.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({super.key});

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> with _AwaitAndPopStateMixin {
  @override
  void initState() {
    // Widgetの描画が完了するまで待機
    WidgetsBinding.instance.endOfFrame.then((_) {
      awaitAndPush();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

mixin _AwaitAndPopStateMixin on State<StartUpView> {
  Future<void> awaitAndPush() async {
    // 500ミリ秒待機
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    // WeatherView に遷移
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const WeatherView(),
      ),
    );
    await awaitAndPush();
  }
}
