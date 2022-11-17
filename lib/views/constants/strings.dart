import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  const Strings._();

  static const ok = 'OK';

  // Errors
  static const simpleError = 'エラーが発生しました';

  static const unknownError = '不明のエラーです';

  static const invalidParameterError = 'パラメータが無効です';
}
