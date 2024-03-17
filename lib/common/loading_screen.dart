import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 28),
            child: Text('Caricamento risultati...', style: TextStyle(fontSize: 22),),
          )
        ]));
  }
}