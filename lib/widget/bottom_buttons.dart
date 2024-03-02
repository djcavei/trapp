import 'package:flutter/material.dart';

class BottomButtons extends StatefulWidget {
  final VoidCallback openMonitorNewAppCallback;
  const BottomButtons({
    super.key,
    required this.openMonitorNewAppCallback
  });

  @override
  State<StatefulWidget> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
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
          child: BasicAddButtons(
            colorScheme: colorScheme,
            text: 'Aggiungi nuova regola',
            onPressFunc: () {
              print('nuova regola');
            },
          ), // todo non funziona
        ),
      ),
      Visibility(
        visible: _showOptions,
        child: Positioned(
          right: 60,
          child: BasicAddButtons(
            colorScheme: colorScheme,
            text: 'Monitora nuova app',
            onPressFunc: /*widget.openMonitorNewAppCallback*/(){}
          ), // todo non funziona
        ),
      ),
      FloatingActionButton(
        backgroundColor: colorScheme.secondary,
        onPressed: widget.openMonitorNewAppCallback,// todo ripristina il codice seguente: () => setState(() => _showOptions = !_showOptions),
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
          backgroundColor: MaterialStatePropertyAll(colorScheme.secondary),
          foregroundColor: MaterialStatePropertyAll(colorScheme.onSecondary)),
      onPressed: onPressFunc,
      child: Text(text),
    );
  }
}
