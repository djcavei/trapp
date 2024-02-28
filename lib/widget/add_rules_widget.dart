import 'package:flutter/material.dart';

class AddRulesWidget extends StatefulWidget {
  const AddRulesWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AddRulesWidgetState();
}

class _AddRulesWidgetState extends State<AddRulesWidget> {
  bool _showOptions = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(clipBehavior: Clip.none, children: [
      Visibility(
        visible: _showOptions,
        child: Positioned(
          right: 60,
          bottom: 60,
          child: BasicAddButtons(colorScheme: colorScheme, text: 'Aggiungi nuova regola', onPressFunc: (){print('nuova regola');},),
        ),
      ),
      Visibility(
        visible: _showOptions,
        child: Positioned(
          right: 60,
          child: BasicAddButtons(colorScheme: colorScheme, text: 'Monitora nuova app', onPressFunc: () => print('nuova app'),),
        ),
      ),
      FloatingActionButton(
        backgroundColor: colorScheme.secondary,
        onPressed: () => setState(() => _showOptions = !_showOptions),
        child: const Icon(
          Icons.add,
          size: 26,
        ),
      ),
    ]);
  }
}

class BasicAddButtons extends StatelessWidget {
  const BasicAddButtons({
    super.key,
    required this.colorScheme,
    required this.text,
    required this.onPressFunc,
  });

  final ColorScheme colorScheme;
  final String text;
  final VoidCallback onPressFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(4),
          shadowColor: MaterialStatePropertyAll(colorScheme.onTertiary),
          overlayColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.5)),
          backgroundColor:
              MaterialStatePropertyAll(colorScheme.secondary),
          foregroundColor:
              MaterialStatePropertyAll(colorScheme.onSecondary)),
      onPressed: onPressFunc,
      child: Text(text),
    );
  }
}
