import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';

import '../functions/functions.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            minimumSize: minimumButtonSize,
            backgroundColor: getSurfaceBackground(context),
            foregroundColor: getSurfaceForeground(context)),
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("No"));
  }
}

class ConfirmButtonWithCallback extends StatelessWidget {
  final VoidCallback voidCallback;

  const ConfirmButtonWithCallback({super.key, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            minimumSize: minimumButtonSize,
            backgroundColor: getErrorBackground(context),
            foregroundColor: getErrorForeground(context)),
        onPressed: voidCallback,
        child: const Text("Si"));
  }
}
