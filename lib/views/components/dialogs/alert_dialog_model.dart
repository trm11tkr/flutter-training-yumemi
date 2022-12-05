import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  const AlertDialogModel({
    required this.title,
    this.message,
    required this.buttons,
    this.onWillPop,
  });

  final String title;
  final String? message;
  final Map<String, T> buttons;
  final void Function()? onWillPop;
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            onWillPop?.call();
            return Future.value(true);
          },
          child: AlertDialog(
            title: Text(title),
            content: message != null ? Text(message!) : null,
            actions: buttons.entries
                .map(
                  (entry) => TextButton(
                    onPressed: () {
                      onWillPop?.call();
                      Navigator.of(context).pop(entry.value);
                    },
                    child: Text(entry.key),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
