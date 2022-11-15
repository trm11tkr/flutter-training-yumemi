import 'package:flutter/foundation.dart';
import 'package:simple_logger/simple_logger.dart';

late SimpleLogger _logger;
SimpleLogger get logger => _logger;

class Logger {
  Logger._();
  static void configure() {
    _logger = SimpleLogger()
      ..setLevel(
        // リリースビルドの場合レベルOFF
        kReleaseMode ? Level.OFF : Level.FINE,
      );
  }
}
