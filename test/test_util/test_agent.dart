import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Default device size during testing is (800 x 600),
// so set device size(1080 x 1920)
Future<void> setUpOfDeviceSize() async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  await binding.setSurfaceSize(
    const Size(1080, 1920),
  );
}
