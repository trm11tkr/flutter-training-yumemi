import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  const Strings._();

  static const ok = 'OK';

  // Errors
  static const unknownError = '不明のエラーです';

  static const invalidParameterError = 'パラメータが無効です';

  static const otherError = 'エラーが発生しました';
}
