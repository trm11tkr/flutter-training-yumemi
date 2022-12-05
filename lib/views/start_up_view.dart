import 'package:flutter/material.dart';
import 'package:flutter_training/views/weather_view.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({super.key});

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> with AfterLayoutMixin {
  @override
  void afterFirstLayout() {
    awaitAndPush();
  }

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    // 描画完了を待機
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) {
        afterFirstLayout();
      }
    });
  }

  void afterFirstLayout() {}
}
