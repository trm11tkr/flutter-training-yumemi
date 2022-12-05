import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/app.dart';
import 'package:flutter_training/utils/logger.dart';

void main() {
  // Logger初期化
  Logger.configure();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
