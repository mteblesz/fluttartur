import 'package:flutter/material.dart';

void showFailureDialog({
  required BuildContext context,
  required String errorMessage,
  required void Function()? onPressed,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  });
}
