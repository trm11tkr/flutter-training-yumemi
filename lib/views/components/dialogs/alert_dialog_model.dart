import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  const AlertDialogModel({
    required this.title,
    this.message,
    required this.buttons,
  });

  final String title;
  final String? message;
  final Map<String, T> buttons;
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: message != null ? Text(message!) : null,
          actions: buttons.entries
              .map(
                (entry) => TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(entry.value);
                  },
                  child: Text(entry.key),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
