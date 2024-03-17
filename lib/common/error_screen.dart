import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 28),
            child: Text('Errore', style: TextStyle(fontSize: 22)),
          )
        ]));
  }
}