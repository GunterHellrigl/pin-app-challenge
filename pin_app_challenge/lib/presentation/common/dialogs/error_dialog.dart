import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.onRetry,
  });

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Ha ocurrido un error'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: const Text('Reintentar'),
        )
      ],
    );
  }

  static void show({
    required BuildContext context,
    required void Function() onRetry,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(onRetry: onRetry);
      },
    );
  }
}
