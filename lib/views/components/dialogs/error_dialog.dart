import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:flutter_training/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter_training/views/constants/strings.dart';

@immutable
class ErrorDialog extends AlertDialogModel<void> {
  const ErrorDialog({
    required super.title,
  }) : super(
          buttons: const {
            Strings.ok: true,
          },
        );
}
